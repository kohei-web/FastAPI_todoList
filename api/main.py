from fastapi import FastAPI
from api.routers import task, done

app = FastAPI()


# routing設定
app.include_router(task.router)
app.include_router(done.router)
