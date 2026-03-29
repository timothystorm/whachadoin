from fastapi import APIRouter

router = APIRouter(prefix="/health", tags=["health", "status"])


@router.get("")
async def health() -> dict:
    """
    Health check endpoint to verify that the API is running.
    """
    return {"status": "ok"}


@router.get("/")
async def health_with_slash() -> dict:
    return await health()
