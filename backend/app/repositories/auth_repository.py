from typing import Any

from app.db.supabase import supabase


class AuthRepository:
    async def sign_up(
        self,
        email: str,
        password: str,
        full_name: str | None = None,
    ) -> Any:
        options = {}

        if full_name:
            options["data"] = {
                "full_name": full_name,
            }

        return supabase.auth.sign_up(
            {
                "email": email,
                "password": password,
                "options": options,
            }
        )

    async def sign_in(
        self,
        email: str,
        password: str,
    ) -> Any:
        return supabase.auth.sign_in_with_password(
            {
                "email": email,
                "password": password,
            }
        )

    async def sign_out(self) -> None:
        supabase.auth.sign_out()