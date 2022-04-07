from typing import NamedTuple, Iterable

from sqlalchemy import text


class TableValuedParams(NamedTuple):

    table_type: str
    rows: Iterable
    columns: Iterable


def prepare_exec(procedure, *args, **kwargs):
    if args and kwargs:
        raise ValueError('Parameters must be all positional or all keyed')

    statements = []
    exec_params = []
    bind_params = {}

    for index, arg in enumerate(args):
        bind_params[f'a{index}'] = arg
        exec_params.append(f':a{index}')

    for key, value in kwargs.items():
        if isinstance(value, TableValuedParams):
            values = []
            
            for row_index, row in enumerate(value.rows):
                row_params = []
                for col_index, col in enumerate(row):
                    
                    param = f'{key}_{row_index}_{col_index}'
                    bind_params[param] = col
                    row_params.append(f':{param}')
                values.append(f'({",".join(row_params)})')
            statements.append(f'DECLARE @{key} AS {value.table_type}')
            columns = f'({",".join(value.columns)})' if value.columns else ''
            statements.append(f'INSERT INTO @{key} {columns} VALUES {",".join(values)}')
            exec_params.append(f'@{key}=@{key}')
        else:
            bind_params[key] = value
            exec_params.append(f'@{key}=:{key}')

    statements.append(f'EXEC {procedure} {",".join(exec_params)}')
    statement = '\n'.join(statements)
    return text(statement).bindparams(**bind_params)