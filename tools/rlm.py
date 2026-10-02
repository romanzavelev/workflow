"""CLI-обёртка над MCP-сервером rlm-tools-bsl.
Использование: rlm.py <путь_к_выгрузке> "<вопрос>" "<python-код с хелперами>" [домены через запятую]
"""
import asyncio, json, sys
from mcp import ClientSession, StdioServerParameters
from mcp.client.stdio import stdio_client

def text(res):
    return "\n".join(c.text for c in res.content if getattr(c, "type", "") == "text")

async def main(path, query, code, domains):
    p = StdioServerParameters(command="rlm-tools-bsl", args=[], env={"RLM_LOG_LEVEL": "WARNING", "PATH": __import__("os").environ["PATH"], "HOME": __import__("os").environ["HOME"]})
    async with stdio_client(p, errlog=open("/dev/null", "w")) as (r, w):
        async with ClientSession(r, w) as s:
            await s.initialize()
            st = text(await s.call_tool("rlm_start", {"path": path, "query": query, "domains": domains}))
            try:
                sid = json.loads(st)["session_id"]
            except Exception:
                print(st); return
            print(text(await s.call_tool("rlm_execute", {"session_id": sid, "code": code})))
            await s.call_tool("rlm_end", {"session_id": sid})

a = sys.argv
doms = [d for d in a[4].split(",") if d] if len(a) > 4 else []
asyncio.run(main(a[1], a[2], a[3], doms))
