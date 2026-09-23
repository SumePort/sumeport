from typing import Any

from supabase import create_client

from app.core.config import settings


class AuthRepository:
    def _auth_client(self):
        # User authentication must use the public anon key client.
        # The service-role client is reserved for privileged database operations.
        return create_client(
            settings.supabase_url,
            settings.supabase_anon_key,
        )

    async def sign_up(self, email: str, password: str, full_name: str | None = None) -> Any:
        options = {}
        if full_name:
            options["data"] = {"full_name": full_name}
        return self._auth_client().auth.sign_up({
            "email": email,
            "password": password,
            "options": options,
        })

    async def sign_in(self, email: str, password: str) -> Any:
        return self._auth_client().auth.sign_in_with_password({
            "email": email,
            "password": password,
        })
