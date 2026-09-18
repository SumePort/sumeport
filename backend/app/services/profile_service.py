from fastapi import HTTPException, status

from app.repositories.profile_repository import ProfileRepository


class ProfileService:

    def __init__(self) -> None:
        self.repository = ProfileRepository()

    async def get_profile(self, user_id: str) -> dict:
        try:
            profile = await self.repository.get_profile(user_id)

            if profile is None:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Career profile not found.",
                )

            return profile

        except HTTPException:
            raise

        except Exception as exc:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Unable to load career profile.",
            ) from exc

    async def update_profile(
        self,
        user_id: str,
        data: dict,
    ) -> dict:
        try:
            profile = await self.repository.update_profile(
                user_id=user_id,
                data=data,
            )

            if profile is None:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Career profile not found.",
                )

            return profile

        except HTTPException:
            raise

        except Exception as exc:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail="Unable to update career profile.",
            ) from exc