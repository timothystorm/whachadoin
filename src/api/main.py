import uvicorn
from api.routers.health_router import router as HealthRouter
from api.settings import settings
from fastapi import FastAPI


def create_app() -> FastAPI:
    """Factory function to create and configure the FastAPI app."""
    api = FastAPI(title="WachaDoin API", version="1.0.0")

    # Include routers here (e.g., api.include_router(your_router))
    api.include_router(HealthRouter)

    # Return the FastAPI app instance
    return api


app = create_app()


def start() -> None:
    """Entry point for running the API server."""
    uvicorn.run(
        "api.main:app",
        host=settings.UVICORN_HOST,
        port=settings.UVICORN_PORT,
        reload=settings.UVICORN_RELOAD,
        workers=settings.UVICORN_WORKERS,
        log_level=settings.UVICORN_LOG_LEVEL,
        access_log=settings.UVICORN_ACCESS_LOG,
    )


if __name__ == "__main__":
    start()
