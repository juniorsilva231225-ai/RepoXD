from fastapi import FastAPI

from Presentation.controller.chatbot_controller import router as chatbot_router
from Presentation.controller.websocket_controller import router as websocket_router

app = FastAPI()

app.include_router(chatbot_router)
app.include_router(websocket_router)