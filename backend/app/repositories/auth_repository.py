from typing import Any

from supabase import create_client

from app.core.config import settings
from app.db.supabase import supabase


class AuthRepository:
    def _auth_client(self):
        # User authentication must use the public anon key client.
        # The service-role client is reserved for privileged database operations.
        return create_client(
            settings.supabase_url,
            settings.supabase_anon_key,
        )

    async def sign_up(
        self,
        email: str,
        password: str,
        full_name: str | None = None,
    ) -> Any:
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

    async def ensure_profile(
        self,
        user_id: str,
        email: str | None = None,
        full_name: str | None = None,
    ) -> Any:
        """Create the SumePort profile if Auth has a user without one.

        The profile primary key is the Supabase Auth user UUID, so this is
        safe to call repeatedly after email or OAuth authentication.
        """
        existing = (
            supabase
            .table("profiles")
            .select("id")
            .eq("id", user_id)
            .maybe_single()
            .execute()
        )

        if existing.data is not None:
            return existing.data

        payload = {"id": user_id}
        if full_name:
            payload["full_name"] = full_name

        return (
            supabase
            .table("profiles")
            .upsert(payload, on_conflict="id")
            .execute()
        ).data

    async def request_password_reset(self, email: str) -> None:
        self._auth_client().auth.reset_password_for_email(email)
