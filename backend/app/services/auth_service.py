from fastapi import HTTPException, status

from app.repositories.auth_repository import AuthRepository
from app.schemas.auth import AuthResponse


class AuthService:
    def __init__(self) -> None:
        self.repository = AuthRepository()

    async def sign_up(
        self,
        email: str,
        password: str,
        full_name: str | None = None,
    ) -> dict:
        try:
            response = await self.repository.sign_up(
                email=email,
                password=password,
                full_name=full_name,
            )

            user = response.user
            session = response.session

            if user is None:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Unable to create account.",
                )

            return {
                "message": (
                    "Account created. "
                    "Please verify your email before signing in."
                ),
                "user_id": str(user.id),
                "email": user.email,
                "email_verified": user.email_confirmed_at is not None,
                "session": (
                    {
                        "access_token": session.access_token,
                        "refresh_token": session.refresh_token,
                    }
                    if session
                    else None
                ),
            }

        except HTTPException:
            raise

        except Exception as exc:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=str(exc),
            ) from exc

    async def sign_in(
        self,
        email: str,
        password: str,
    ) -> AuthResponse:
        try:
            response = await self.repository.sign_in(
                email=email,
                password=password,
            )

            user = response.user
            session = response.session

            if user is None or session is None:
                raise HTTPException(
                    status_code=status.HTTP_401_UNAUTHORIZED,
                    detail="Invalid email or password.",
                )

            provider = str(
                (user.app_metadata or {}).get("provider") or "email"
            )

            return AuthResponse(
                access_token=session.access_token,
                refresh_token=session.refresh_token,
                user_id=str(user.id),
                email=user.email or email,
                email_verified=user.email_confirmed_at is not None,
                provider=provider,
            )

        except HTTPException:
            raise

        except Exception as exc:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail=str(exc),
            ) from exc