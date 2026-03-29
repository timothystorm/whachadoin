from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")

    # UVICORN settings
    UVICORN_HOST: str = "0.0.0.0"
    UVICORN_PORT: int = 8000
    UVICORN_RELOAD: bool = False
    UVICORN_WORKERS: int = 1
    UVICORN_LOG_LEVEL: str = "info"
    UVICORN_ACCESS_LOG: bool = False

settings = Settings()