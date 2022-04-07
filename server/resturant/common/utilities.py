import re
import json


camel_case_pattern = re.compile(r'[A-Z][a-z]+|[A-Z]+|[a-z]+|[0-9]+')


def camelcase(s):
    words = camel_case_pattern.findall(s)
    out = ''.join(w.title() for w in words)
    return out[0].lower() + out[1:]



def camelcase_recurse(obj):
    if isinstance(obj, dict):
        return {
            camelcase(key) if isinstance(key, str) else key: camelcase_recurse(value)
            for key, value
            in obj.items()
        }
    if isinstance(obj, list):
        return [
            camelcase_recurse(value)
            for value
            in obj
        ]
    return obj

def mapAndJoin(Listdata):
    val=""
    for d in Listdata:
        for key in d:
            val += str(d[key]) +","
    return val

  
