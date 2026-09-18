from fastapi import APIRouter, Depends

from app.core.security import get_current_user
from app.schemas.profile import ProfileUpdate
from app.services.profile_service import ProfileService


router = APIRouter()
profile_service = ProfileService()


@router.get("")
async def get_profile(
    current_user=Depends(get_current_user),
):
    return await profile_service.get_profile(
        user_id=str(current_user.id),
    )


@router.patch("")
async def update_profile(
    request: ProfileUpdate,
    current_user=Depends(get_current_user),
):
    data = request.model_dump(
        exclude_unset=True,
    )

    return await profile_service.update_profile(
        user_id=str(current_user.id),
        data=data,
    )