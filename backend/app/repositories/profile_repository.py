from typing import Any

from app.db.supabase import supabase


class ProfileRepository:

    async def get_profile(self, user_id: str) -> Any:
        response = (
            supabase
            .table("profiles")
            .select("*")
            .eq("id", user_id)
            .single()
            .execute()
        )

        return response.data

    async def update_profile(
        self,
        user_id: str,
        data: dict,
    ) -> Any:
        if not data:
            return await self.get_profile(user_id)

        response = (
            supabase
            .table("profiles")
            .update(data)
            .eq("id", user_id)
            .execute()
        )

        if not response.data:
            return None

        return response.data[0]