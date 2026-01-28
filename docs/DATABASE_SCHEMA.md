# Database Schema (Firestore)

## Overview
Chairific uses Firebase Firestore, a NoSQL cloud database. Below is the Entity Relationship structure.

## Collections and Documents

### 1. Users Collection
**Collection**: `users`

**Document Structure**:
```
users/{userId}
  ├─ type: string ("employee" | "employer")
  ├─ email: string
  ├─ isAnonymous: boolean
  ├─ createdAt: timestamp
  └─ profile: reference → profiles/{profileId}
```

### 2. Profiles Collection
**Collection**: `profiles`

**Employee Profile**:
```
profiles/{profileId}
  ├─ userId: string (reference)
  ├─ type: "employee"
  ├─ skills: array[string] (top 5 skills)
  ├─ hobbies: array[string]
  ├─ questionnaireAnswers: map{
  │    questionId: answer
  │  }
  ├─ revealed: boolean
  └─ updatedAt: timestamp
```

**Employer Profile**:
```
profiles/{profileId}
  ├─ userId: string (reference)
  ├─ type: "employer"
  ├─ companyName: string (hidden until reveal)
  ├─ companyCulture: string
  ├─ benefits: array[string]
  ├─ questionnaireAnswers: map{
  │    questionId: answer
  │  }
  ├─ positions: array[reference] → positions/{positionId}
  └─ updatedAt: timestamp
```

### 3. Positions Collection
**Collection**: `positions`

```
positions/{positionId}
  ├─ employerId: string
  ├─ title: string
  ├─ description: string
  ├─ requiredSkills: array[string] (3 required)
  ├─ active: boolean
  └─ createdAt: timestamp
```

### 4. Matches Collection
**Collection**: `matches`

```
matches/{matchId}
  ├─ employeeId: string
  ├─ employerId: string
  ├─ positionId: string
  ├─ matchScore: number
  ├─ skillAlignment: number
  ├─ cultureAlignment: number
  ├─ status: string ("pending" | "accepted" | "revealed" | "declined")
  ├─ employeeRevealed: boolean
  ├─ employerRevealed: boolean
  ├─ createdAt: timestamp
  └─ updatedAt: timestamp
```

### 5. Questions Collection
**Collection**: `questions`

```
questions/{questionId}
  ├─ questionText: string
  ├─ type: string ("employee" | "employer")
  ├─ category: string
  └─ weight: number (for matching algorithm)
```

## Entity Relationship Diagram

```
┌─────────────┐         1:1          ┌─────────────┐
│    Users    │─────────────────────▶│  Profiles   │
└─────────────┘                       └─────────────┘
                                            │
                                            │ 1:N
                                            ▼
                                      ┌─────────────┐
                                      │  Positions  │
                                      └─────────────┘
                                            │
                                            │
        ┌───────────────────────────────────┤
        │                                   │
        │ N:M                               │
        ▼                                   │
┌─────────────┐         N:1                │
│   Matches   │◀────────────────────────────┘
└─────────────┘
        │
        │ N:N
        ▼
┌─────────────┐
│  Questions  │
└─────────────┘
```

## Key Relationships

1. **User ↔ Profile**: One-to-One relationship
2. **Employer Profile ↔ Positions**: One-to-Many relationship
3. **Employees ↔ Positions**: Many-to-Many through Matches
4. **Profiles ↔ Questions**: Many-to-Many (answers stored in profile)

## Indexes

For optimal query performance, the following composite indexes are recommended:

1. **Matches Collection**:
   - `(employeeId, status)`
   - `(employerId, status)`
   - `(matchScore, DESC)`

2. **Positions Collection**:
   - `(employerId, active)`

3. **Profiles Collection**:
   - `(userId)`
   - `(type, revealed)`

## Data Privacy Notes

- User identities remain anonymous until both parties agree to reveal
- Company names are stored but not shared until reveal
- All questionnaire answers are stored securely
- Matching algorithm runs on anonymized data
