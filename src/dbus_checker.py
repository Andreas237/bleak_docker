import os
import sys

sys.path.append(os.path.abspath(os.path.dirname(__file__) + "/.."))

import asyncio
import json
from pprint import pprint

from dbus_fast import Message, MessageType
from dbus_fast.aio import MessageBus



async def main():
    bus = await MessageBus().connect()

    reply = await bus.call(
        Message(
            destination="org.freedesktop.DBus",
            path="/org/freedesktop/DBus",
            interface="org.freedesktop.DBus",
            member="ListNames",
        )
    )

    if reply.message_type == MessageType.ERROR:
        raise Exception(reply.body[0])

    pprint(json.dumps(reply.body[0], indent=2))


asyncio.run(main())




from bluetooth_adapters import get_adapters


async def go() -> None:
    bluetooth_adapters = get_adapters()
    await bluetooth_adapters.refresh()
    print(bluetooth_adapters.adapters)


asyncio.run(go())


