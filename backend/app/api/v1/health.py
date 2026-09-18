from fastapi import APIRouter

from app.db.supabase import supabase


router = APIRouter()


@router.get("/health")
async def health_check():
    return {
        "status": "ok",
        "supabase": "configured",
    }