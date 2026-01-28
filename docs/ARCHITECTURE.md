# System Architecture

## Overview
This document describes the system architecture of Chairific, a bias-free job matching iOS application.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     Chairific iOS App                        │
│                      (SwiftUI)                               │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ Onboarding   │  │   Profile    │  │   Matching   │      │
│  │   Views      │  │    Views     │  │    Views     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│         │                  │                  │              │
│         └──────────────────┴──────────────────┘              │
│                          │                                   │
│                  ┌───────▼────────┐                         │
│                  │  Controllers   │                         │
│                  │  (View Models) │                         │
│                  └───────┬────────┘                         │
└──────────────────────────┼──────────────────────────────────┘
                           │
                           ▼
                  ┌────────────────┐
                  │ Firebase SDK   │
                  └────────┬───────┘
                           │
        ┏━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━┓
        ▼                                    ▼
┌───────────────┐                  ┌──────────────────┐
│   Firebase    │                  │    Firebase      │
│ Authentication│                  │   Firestore      │
│               │                  │   (Database)     │
└───────────────┘                  └──────────────────┘
```

## Key Components

### Frontend (iOS App)
- **SwiftUI Framework**: Modern declarative UI framework
- **Views**: Organized by feature (Onboarding, Profile, Matching, Swiping, Settings)
- **Controllers**: Business logic and state management

### Backend Services
- **Firebase Authentication**: User authentication and session management
- **Firebase Firestore**: NoSQL cloud database for storing user profiles, matches, and questionnaire responses

## Data Flow

1. **User Registration**: User creates account → Firebase Auth → User document created in Firestore
2. **Profile Creation**: User completes profile → Data stored in Firestore (anonymized)
3. **Matching Algorithm**: 
   - Skills and culture questions analyzed
   - Algorithm runs matching logic
   - Matches stored in Firestore
4. **Match Reveal**: Both parties agree → Identity revealed → Interview process begins

## Security & Privacy
- All profiles are anonymized until mutual match agreement
- Firebase Authentication handles secure user sessions
- Firestore security rules ensure data privacy:
  - Users can only read/write their own profile data
  - Match data is only accessible to the two parties involved
  - Company information remains hidden until explicit reveal
  - Questionnaire responses are private to profile owners
