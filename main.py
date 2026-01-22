import fastapi as FastAPI
from  api.routes import ingest


app = FastAPI.FastAPI(title = "Zarnex")


app.include_router(ingest.router, prefix="/ingest")



@app.get("/")
def health():
    return {"status": "ok"}