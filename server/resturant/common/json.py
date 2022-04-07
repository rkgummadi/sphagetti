from datetime import datetime
from json import JSONEncoder
from decimal import Decimal

from aiohttp.web import json_response


class ExtendedJSONEncoder(JSONEncoder):

    def default(self, obj):
        if isinstance(obj, Decimal):
            return str(obj)
        if isinstance(obj, datetime):
            return obj.isoformat()
        return super().default(obj)


json_encoder = ExtendedJSONEncoder()


def jsonify(*args, **kwargs):
    return json_response(*args, **kwargs, dumps=json_encoder.encode)
