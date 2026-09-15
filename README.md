# ClashGuard

## Overview
ClashGuard is an iOS app that detects clashes between a casual worker's
academic deadlines and their work roster. It reads both calendars and
flags the moment a shift overlaps a deadline, so the student has time to
act instead of finding out too late.

## Domain context
Casual student workers often juggle two calendars that never talk to
each other, a university timetable and assessment schedule, and a work
roster set by an employer. Rosters are often published with little
notice, so a shift can land on the same day as an assignment without
the student noticing until it is too late. ClashGuard exists to close
that gap.

## Architecture
The app follows MVVM with a dedicated Use Case layer between the
ViewModels and the domain data.

Views talk only to ViewModels.
ViewModels talk only to Use Cases.
Use Cases contain the business rules and talk to Repositories.
Repositories are the only place that touches raw data.

Folder structure:
- Views. SwiftUI screens
- ViewModels. State and presentation logic for each screen
- UseCases. One struct per business operation, for example detecting a clash
- Domain. Core models such as RosterShift and AcademicDeadline
- Repositories. Reads and writes domain data

## Setup
1. Open ClashGuard.xcodeproj in Xcode
2. Select the ClashGuard scheme
3. Choose any iPhone simulator
4. Press Run
