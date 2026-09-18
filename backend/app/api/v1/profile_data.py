from fastapi import APIRouter, Depends, HTTPException

from app.core.security import get_current_user
from app.repositories.profile_data_repository import ProfileDataRepository
from app.schemas.profile import (
    AchievementCreate,
    AchievementUpdate,
    CertificationCreate,
    CertificationUpdate,
    EducationCreate,
    EducationUpdate,
    ExperienceCreate,
    ExperienceUpdate,
    ProjectCreate,
    ProjectUpdate,
    SkillCreate,
    SkillUpdate,
    CareerPreferencesUpdate,
)

router = APIRouter()
repository = ProfileDataRepository()


# ============================================================
# EDUCATION
# ============================================================

@router.get("/education")
async def list_education(current_user=Depends(get_current_user)):
    return await repository.list_items(
        "education",
        str(current_user.id),
    )


@router.post("/education")
async def create_education(
    request: EducationCreate,
    current_user=Depends(get_current_user),
):
    return await repository.create_item(
        "education",
        str(current_user.id),
        request.model_dump(mode="json"),
    )


@router.patch("/education/{item_id}")
async def update_education(
    item_id: str,
    request: EducationUpdate,
    current_user=Depends(get_current_user),
):
    result = await repository.update_item(
        "education",
        str(current_user.id),
        item_id,
        request.model_dump(exclude_unset=True, mode="json"),
    )

    if result is None:
        raise HTTPException(
            status_code=404,
            detail="Education record not found.",
        )

    return result


@router.delete("/education/{item_id}")
async def delete_education(
    item_id: str,
    current_user=Depends(get_current_user),
):
    deleted = await repository.delete_item(
        "education",
        str(current_user.id),
        item_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=404,
            detail="Education record not found.",
        )

    return {"message": "Education record deleted."}


# ============================================================
# EXPERIENCE
# ============================================================

@router.get("/experience")
async def list_experience(current_user=Depends(get_current_user)):
    return await repository.list_items(
        "experience",
        str(current_user.id),
    )


@router.post("/experience")
async def create_experience(
    request: ExperienceCreate,
    current_user=Depends(get_current_user),
):
    return await repository.create_item(
        "experience",
        str(current_user.id),
        request.model_dump(mode="json"),
    )


@router.patch("/experience/{item_id}")
async def update_experience(
    item_id: str,
    request: ExperienceUpdate,
    current_user=Depends(get_current_user),
):
    result = await repository.update_item(
        "experience",
        str(current_user.id),
        item_id,
        request.model_dump(exclude_unset=True, mode="json"),
    )

    if result is None:
        raise HTTPException(
            status_code=404,
            detail="Experience record not found.",
        )

    return result


@router.delete("/experience/{item_id}")
async def delete_experience(
    item_id: str,
    current_user=Depends(get_current_user),
):
    deleted = await repository.delete_item(
        "experience",
        str(current_user.id),
        item_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=404,
            detail="Experience record not found.",
        )

    return {"message": "Experience record deleted."}


# ============================================================
# SKILLS
# ============================================================

@router.get("/skills")
async def list_skills(current_user=Depends(get_current_user)):
    return await repository.list_items(
        "skills",
        str(current_user.id),
    )


@router.post("/skills")
async def create_skill(
    request: SkillCreate,
    current_user=Depends(get_current_user),
):
    return await repository.create_item(
        "skills",
        str(current_user.id),
        request.model_dump(mode="json"),
    )


@router.patch("/skills/{item_id}")
async def update_skill(
    item_id: str,
    request: SkillUpdate,
    current_user=Depends(get_current_user),
):
    result = await repository.update_item(
        "skills",
        str(current_user.id),
        item_id,
        request.model_dump(exclude_unset=True, mode="json"),
    )

    if result is None:
        raise HTTPException(
            status_code=404,
            detail="Skill not found.",
        )

    return result


@router.delete("/skills/{item_id}")
async def delete_skill(
    item_id: str,
    current_user=Depends(get_current_user),
):
    deleted = await repository.delete_item(
        "skills",
        str(current_user.id),
        item_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=404,
            detail="Skill not found.",
        )

    return {"message": "Skill deleted."}


# ============================================================
# PROJECTS
# ============================================================

@router.get("/projects")
async def list_projects(current_user=Depends(get_current_user)):
    return await repository.list_items(
        "projects",
        str(current_user.id),
    )


@router.post("/projects")
async def create_project(
    request: ProjectCreate,
    current_user=Depends(get_current_user),
):
    return await repository.create_item(
        "projects",
        str(current_user.id),
        request.model_dump(mode="json"),
    )


@router.patch("/projects/{item_id}")
async def update_project(
    item_id: str,
    request: ProjectUpdate,
    current_user=Depends(get_current_user),
):
    result = await repository.update_item(
        "projects",
        str(current_user.id),
        item_id,
        request.model_dump(exclude_unset=True, mode="json"),
    )

    if result is None:
        raise HTTPException(
            status_code=404,
            detail="Project not found.",
        )

    return result


@router.delete("/projects/{item_id}")
async def delete_project(
    item_id: str,
    current_user=Depends(get_current_user),
):
    deleted = await repository.delete_item(
        "projects",
        str(current_user.id),
        item_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=404,
            detail="Project not found.",
        )

    return {"message": "Project deleted."}


# ============================================================
# CERTIFICATIONS
# ============================================================

@router.get("/certifications")
async def list_certifications(current_user=Depends(get_current_user)):
    return await repository.list_items(
        "certifications",
        str(current_user.id),
    )


@router.post("/certifications")
async def create_certification(
    request: CertificationCreate,
    current_user=Depends(get_current_user),
):
    return await repository.create_item(
        "certifications",
        str(current_user.id),
        request.model_dump(mode="json"),
    )


@router.patch("/certifications/{item_id}")
async def update_certification(
    item_id: str,
    request: CertificationUpdate,
    current_user=Depends(get_current_user),
):
    result = await repository.update_item(
        "certifications",
        str(current_user.id),
        item_id,
        request.model_dump(exclude_unset=True, mode="json"),
    )

    if result is None:
        raise HTTPException(
            status_code=404,
            detail="Certification not found.",
        )

    return result


@router.delete("/certifications/{item_id}")
async def delete_certification(
    item_id: str,
    current_user=Depends(get_current_user),
):
    deleted = await repository.delete_item(
        "certifications",
        str(current_user.id),
        item_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=404,
            detail="Certification not found.",
        )

    return {"message": "Certification deleted."}


# ============================================================
# ACHIEVEMENTS
# ============================================================

@router.get("/achievements")
async def list_achievements(current_user=Depends(get_current_user)):
    return await repository.list_items(
        "achievements",
        str(current_user.id),
    )


@router.post("/achievements")
async def create_achievement(
    request: AchievementCreate,
    current_user=Depends(get_current_user),
):
    return await repository.create_item(
        "achievements",
        str(current_user.id),
        request.model_dump(mode="json"),
    )


@router.patch("/achievements/{item_id}")
async def update_achievement(
    item_id: str,
    request: AchievementUpdate,
    current_user=Depends(get_current_user),
):
    result = await repository.update_item(
        "achievements",
        str(current_user.id),
        item_id,
        request.model_dump(exclude_unset=True, mode="json"),
    )

    if result is None:
        raise HTTPException(
            status_code=404,
            detail="Achievement not found.",
        )

    return result


@router.delete("/achievements/{item_id}")
async def delete_achievement(
    item_id: str,
    current_user=Depends(get_current_user),
):
    deleted = await repository.delete_item(
        "achievements",
        str(current_user.id),
        item_id,
    )

    if not deleted:
        raise HTTPException(
            status_code=404,
            detail="Achievement not found.",
        )

    return {"message": "Achievement deleted."}


# ============================================================
# CAREER PREFERENCES
# ============================================================

@router.get("/preferences")
async def get_preferences(current_user=Depends(get_current_user)):
    items = await repository.list_items(
        "career_preferences",
        str(current_user.id),
    )

    return items[0] if items else None


@router.put("/preferences")
async def update_preferences(
    request: CareerPreferencesUpdate,
    current_user=Depends(get_current_user),
):
    user_id = str(current_user.id)

    data = request.model_dump(mode="json")

    existing = await repository.list_items(
        "career_preferences",
        user_id,
    )

    if existing:
        result = await repository.update_item(
            "career_preferences",
            user_id,
            existing[0]["id"],
            data,
        )
    else:
        result = await repository.create_item(
            "career_preferences",
            user_id,
            data,
        )

    return result