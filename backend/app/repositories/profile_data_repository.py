from typing import Any

from app.db.supabase import supabase


class ProfileDataRepository:

    async def list_items(
        self,
        table: str,
        user_id: str,
    ) -> list[dict]:
        response = (
            supabase
            .table(table)
            .select("*")
            .eq("profile_id", user_id)
            .order("created_at")
            .execute()
        )

        return response.data or []

    async def create_item(
        self,
        table: str,
        user_id: str,
        data: dict,
    ) -> dict:
        payload = {
            **data,
            "profile_id": user_id,
        }

        response = (
            supabase
            .table(table)
            .insert(payload)
            .execute()
        )

        return response.data[0]

    async def update_item(
        self,
        table: str,
        user_id: str,
        item_id: str,
        data: dict,
    ) -> dict | None:
        response = (
            supabase
            .table(table)
            .update(data)
            .eq("id", item_id)
            .eq("profile_id", user_id)
            .execute()
        )

        if not response.data:
            return None

        return response.data[0]

    async def delete_item(
        self,
        table: str,
        user_id: str,
        item_id: str,
    ) -> bool:
        response = (
            supabase
            .table(table)
            .delete()
            .eq("id", item_id)
            .eq("profile_id", user_id)
            .execute()
        )

        return bool(response.data)