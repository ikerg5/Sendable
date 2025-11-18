Original App Design Project - README
===

# Sendable

## Table of Contents

1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)

## Overview

### Description
A mobile app for indoor climbers to log the routes they climb (difficulty, attempts, notes) and share their progress with friends. It's a digital logbook and social feed for the indoor climbing community.

### App Evaluation

- **Category:** Social Networking / Fitness & Tracking
- **Mobile:** Uses the Camera to post routes with photos and Location to identify the gym.
- **Story:** Makes logging climbs rewarding by gamifying progress and connecting climbers. It's about celebrating achievements and sharing tips ("beta") within a dedicated community.
- **Market:** Niche but Engaged. Targets the specific, growing group of indoor boulderers and sport climbers. High value for a tight-knit community looking for an easy-to-use simple digital logbook.
- **Habit:** Very High. Usage is tied directly to the physical hobby (climbing sessions, 2-4 times a week). The social feedback (likes, comments) encourages immediate logging after every climb.
- **Scope:** V1: Allow users to create an account and log a route (difficulty, attempts, notes) to a personal, local list. Focus on fast, easy logging UI. V2: Add photo upload/viewing and a simple feed displaying the user's own recent activity.V3: Implement social features: follow friends, view a public feed, and add comments.V4: Full Camera integration for in-app photo capture and sharing.

## Product Spec

App Name: **Sendable** 

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* As a user, I want to **view my personal profile** which displays all my saved and posted route logs in a single feed.
* As a user, I want to **select a photo** from my media library or **capture a new one** using the camera for the route I climbed.
* As a user, I want to **select the V-Grade** for the route I am logging using a simple picker (V0, V1, V2, etc.).
* As a user, I want to **add a short text note or "beta"** to my log entry.
* As a user, I want to **choose to either 'Save' (private)** or **'Post' (public)** my new entry, making the data persistent locally.
* As a user, I want to be able to **tap any log entry** to see the full photo, grade, and notes on a detail screen.

**Optional Nice-to-have Stories**

* As a user, I want to be able to **filter my profile** to view only my 'Saved' logs or only my 'Posted' logs.
* As a user, I want to be able to **edit the V-Grade and Note** of a log after it has been created.
* As a user, I want the app to **automatically date and time-stamp** my log when I create it.
* As a user, I want to **delete a log entry** from my profile.

---

### 2. Screen Archetypes

- [ ] **Profile/Logbook Screen** (The main landing page, combining saved and posted logs)
* As a user, I want to **view my personal profile** which displays all my saved and posted route logs in a single feed.
* As a user, I want to be able to **tap any log entry** to see the full photo, grade, and notes on a detail screen.
- [ ] **New Log Capture Screen**
* As a user, I want to **select a photo** from my media library or **capture a new one** using the camera.
- [ ] **Log Details & Submit Screen**
* As a user, I want to **select the V-Grade** for the route I am logging.
* As a user, I want to **add a short text note or "beta"** to my log entry.
* As a user, I want to **choose to either 'Save' (private)** or **'Post' (public)** my new entry.
- [ ] **Log Detail View Screen**
* As a user, I want to be able to **tap any log entry** to see the full photo, grade, and notes on a detail screen.

---

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* **Logbook** (Tab to **Profile/Logbook Screen**)
* **New Send** (Tab to **New Log Capture Screen**)
* **Feed** (Tab to **Profile/Logbook Screen**) - *Note: This will display the same consolidated list as the Logbook tab for the MVP.*

**Flow Navigation** (Screen to Screen)

- [ ] **Profile/Logbook Screen**
* Tapping a log entry navigates to the **Log Detail View Screen**.
* Tapping the 'New Send' tab navigates to the **New Log Capture Screen**.
- [ ] **New Log Capture Screen**
* After photo selection, navigates to the **Log Details & Submit Screen**.
* Canceling photo selection returns to the **Profile/Logbook Screen**.
- [ ] **Log Details & Submit Screen**
* After tapping 'Save' or 'Post', navigates back to the **Profile/Logbook Screen** (to see the new entry).
- [ ] **Log Detail View Screen**
* Tapping a back button returns to the **Profile/Logbook Screen**.
## Wireframes

![WireFrame](https://github.com/ikerg5/Sendable/blob/main/WireFrame.png?raw=true)
