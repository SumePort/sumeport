from fastapi import APIRouter, Depends

from app.core.security import get_current_user
from app.schemas.auth import AuthResponse, LoginRequest, SignUpRequest
from app.services.auth_service import AuthService


router = APIRouter()
auth_service = AuthService()


@router.post("/signup")
async def signup(request: SignUpRequest):
    return await auth_service.sign_up(
        email=request.email,
        password=request.password,
        full_name=request.full_name,
    )


@router.post("/login", response_model=AuthResponse)
async def login(request: LoginRequest):
    return await auth_service.sign_in(
        email=request.email,
        password=request.password,
    )


@router.get("/me")
async def get_me(current_user=Depends(get_current_user)):
    app_metadata = current_user.app_metadata or {}
    auth_provider = str(app_metadata.get("provider") or "email")

    return {
        "user_id": str(current_user.id),
        "email": current_user.email,
        "email_verified": current_user.email_confirmed_at is not None,
        "provider": auth_provider,
    }