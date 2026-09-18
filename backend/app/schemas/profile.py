from datetime import date
from decimal import Decimal
from typing import List, Optional
from uuid import UUID

from pydantic import BaseModel, Field


# ============================================================
# PROFILE
# ============================================================

class ProfileUpdate(BaseModel):
    full_name: Optional[str] = None
    avatar_url: Optional[str] = None

    preferred_language: Optional[str] = None
    career_stage: Optional[str] = None

    target_role: Optional[str] = None
    career_goal: Optional[str] = None

    current_location: Optional[str] = None
    preferred_location: Optional[str] = None

    salary_currency: Optional[str] = None

    expected_salary_min: Optional[Decimal] = Field(
        default=None,
        ge=0,
    )

    expected_salary_max: Optional[Decimal] = Field(
        default=None,
        ge=0,
    )


class ProfileResponse(BaseModel):
    id: UUID

    full_name: Optional[str] = None
    avatar_url: Optional[str] = None

    preferred_language: str
    career_stage: Optional[str] = None

    target_role: Optional[str] = None
    career_goal: Optional[str] = None

    current_location: Optional[str] = None
    preferred_location: Optional[str] = None

    salary_currency: Optional[str] = None

    expected_salary_min: Optional[Decimal] = None
    expected_salary_max: Optional[Decimal] = None

    onboarding_completed: bool
    profile_completion: int

    created_at: Optional[str] = None
    updated_at: Optional[str] = None


# ============================================================
# EDUCATION
# ============================================================

class EducationCreate(BaseModel):
    institution: str

    degree: Optional[str] = None
    field_of_study: Optional[str] = None

    start_date: Optional[date] = None
    end_date: Optional[date] = None

    currently_studying: bool = False

    grade: Optional[str] = None
    description: Optional[str] = None


class EducationUpdate(BaseModel):
    institution: Optional[str] = None

    degree: Optional[str] = None
    field_of_study: Optional[str] = None

    start_date: Optional[date] = None
    end_date: Optional[date] = None

    currently_studying: Optional[bool] = None

    grade: Optional[str] = None
    description: Optional[str] = None


# ============================================================
# EXPERIENCE
# ============================================================

class ExperienceCreate(BaseModel):
    company_name: str
    job_title: str

    employment_type: Optional[str] = None
    location: Optional[str] = None

    start_date: Optional[date] = None
    end_date: Optional[date] = None

    currently_working: bool = False

    description: Optional[str] = None

    achievements: List[str] = Field(
        default_factory=list
    )


class ExperienceUpdate(BaseModel):
    company_name: Optional[str] = None
    job_title: Optional[str] = None

    employment_type: Optional[str] = None
    location: Optional[str] = None

    start_date: Optional[date] = None
    end_date: Optional[date] = None

    currently_working: Optional[bool] = None

    description: Optional[str] = None

    achievements: Optional[List[str]] = None


# ============================================================
# SKILLS
# ============================================================

class SkillCreate(BaseModel):
    name: str

    level: str = "beginner"

    years_of_experience: Optional[Decimal] = Field(
        default=None,
        ge=0,
    )

    source: Optional[str] = None


class SkillUpdate(BaseModel):
    name: Optional[str] = None

    level: Optional[str] = None

    years_of_experience: Optional[Decimal] = Field(
        default=None,
        ge=0,
    )

    source: Optional[str] = None


# ============================================================
# PROJECTS
# ============================================================

class ProjectCreate(BaseModel):
    title: str

    description: Optional[str] = None

    technologies: List[str] = Field(
        default_factory=list
    )

    project_url: Optional[str] = None
    repository_url: Optional[str] = None

    start_date: Optional[date] = None
    end_date: Optional[date] = None


class ProjectUpdate(BaseModel):
    title: Optional[str] = None

    description: Optional[str] = None

    technologies: Optional[List[str]] = None

    project_url: Optional[str] = None
    repository_url: Optional[str] = None

    start_date: Optional[date] = None
    end_date: Optional[date] = None


# ============================================================
# CERTIFICATIONS
# ============================================================

class CertificationCreate(BaseModel):
    name: str

    issuing_organization: Optional[str] = None

    issue_date: Optional[date] = None
    expiry_date: Optional[date] = None

    credential_id: Optional[str] = None
    credential_url: Optional[str] = None


class CertificationUpdate(BaseModel):
    name: Optional[str] = None

    issuing_organization: Optional[str] = None

    issue_date: Optional[date] = None
    expiry_date: Optional[date] = None

    credential_id: Optional[str] = None
    credential_url: Optional[str] = None


# ============================================================
# ACHIEVEMENTS
# ============================================================

class AchievementCreate(BaseModel):
    title: str

    description: Optional[str] = None
    date: Optional[date] = None


class AchievementUpdate(BaseModel):
    title: Optional[str] = None

    description: Optional[str] = None
    date: Optional[date] = None


# ============================================================
# CAREER PREFERENCES
# ============================================================

class CareerPreferencesUpdate(BaseModel):
    industries: List[str] = Field(
        default_factory=list
    )

    preferred_job_types: List[str] = Field(
        default_factory=list
    )

    remote_preference: Optional[str] = None

    willing_to_relocate: bool = False

    preferred_countries: List[str] = Field(
        default_factory=list
    )

    work_authorization: Optional[str] = None

    visa_sponsorship_required: bool = False