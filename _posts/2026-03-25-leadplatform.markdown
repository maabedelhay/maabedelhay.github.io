---
layout: post
title: LEAD Platform
date: 2026-03-26 03:12:10
categories: Article
tags: LEAD
author: Mabd
---
* content
{:toc}



Asking the right question is a key. If we want to control the dev cycle and not let the cycle control us, we need to answer some questions before we start.

The platform is a system that empowers us to reach our goal. It will change in form through out different phases.

## Problem at hand

Our country with significant economic potential and highly skilled, creative and authentic people. Held back by a weak economy, poor institutional support, and a leadership vacuum. Between 25% and 33% of the population now lives abroad.

## Solution

Transform the economy from a consuming one to a productive one. Help local businesses find a place in foreign markets and start exporting using expats as the bridge.

<img style="float:right ;width:40%" src="/assets/img/2026-03-25-leadplatform/lead_p.png" />

## What to build

A non-profit platform where local businesses post structured initiatives. Expats can contribute in defined ways: financial backing, legal guidance, logistics coordination, marketing, technical work, or direct mentorship

 <!-- > "turn goodwill into committed, trackable, completed work." -->

## Design decision

- Initiative-lifecycle: it has states (draft → validated → active → fulfilled → archived)

- Reputation: the value a contributor/expat builds must be visible to future local businesses


## Build Path 

<img src="/assets/img/2026-03-25-leadplatform/path-abstrat.png" />

### Phase 0

We should try to run actual process manually with 5-10 real local businesses and 10-20 real expats. Using WhatsApp, Google Forms, and a shared spreadsheet.

We will learn:
- How do local businesses *actually* describe what they need? To be able to create the correct schema
- What makes an expat commit?
- Where does the process break down when it's manual?


### Phase 1

**Goal**: Have real initiatives, real contributors, real outcomes with no custom code.

An openionated stack:

| Layer | Tool | Why This Specifically |
|---|---|---|
| Core database | **Airtable + PostgreSQL mirror** | Airtable for admin/ops teams; Postgres mirror for the next phase |
| Auth & Identity | **Clerk** | Best-in-class for social login, supports org/team structure out of the box, free tier is generous |
| Frontend portal | **Softr** (connected to Airtable) | easy to modify; zero deployment overhead |
| Communication | **Discord/Telegram with structured channels** |  |
| Payments (donations) | **Open Collective** | Already built for transparent nonprofit finances |
| Document signing | **Docuseal** (open source, self-hostable) | Contribution agreements need to be signed! |


### Phase 2

We can start introducing custom code only for the things that genuinely need it.

**What actually needs custom code at this stage:**

1. **The Matching Engine** — an expat in Dresden with logistics expertise in the EU food import chain should surface to a local food producer posting an initiative, not a lawyer in Toronto. Airtable filters can't do this well. A Python service with a scoring algorithm can.

2. **The Contribution State Machine** — we need a defined workflow: *expressed interest → matched → agreement signed → active → milestone verified → completed → reputation updated*. Each state transition needs to be tracked. We can build a API endpoint (FastAPI for example).

3. **The Reputation Ledger** — every completed contribution must produce a verifiable artifact: a signed document, a confirmed milestone, a business rating. Expats who complete 3 initiatives should be visibly more trusted than those who completed 0. This is a database table, but it needs to be *designed intentionally* from the start.

**What we should NOT build custom at this stage:**
- Search 
- Email/notifications
- File storage (use Cloudflare R2 free tier is massive)
- Video calls between expats and local businesses

### Phase 3

Real usage data, a validated schema, a working matching algorithm, a contribution state machine, and a reputation ledger.

**Stack recommendation for the custom build:**


- Backend:     Go 

- Database:    PostgreSQL been mirroring to it since Phase 1

- Search:      Meilisearch, handles Arabic/French/local language characters well

- Auth:        Keycloak

- Frontend:    Next.js 



## The Three Layers We Must Design Explicitly

<img style="float:right ;width:40%" src="/assets/img/2026-03-25-leadplatform/layers.png" />

### Layer 1: Identity & Credentialing

We need a **tiered trust architecture**:

**Local Businesses:**
- Tier 0: Self-registered (can browse, cannot post)
- Tier 1: Community-verified (another local business or a trusted local org vouches for them)
- Tier 2: Document-verified (business registration, tax ID, done asynchronously by a volunteer legal team)


**Expats:**
- Tier 0: Social media accounts verified (OAuth login, profile imported)
- Tier 1: Domain-verified (they've completed one initiative)
- Tier 2: Expert-designated (the community recognizes their specific expertise in a domain)

### Layer 2: The Initiative Schema

This is the most important data design decision we'll make. "Initiative" needs to be a rich, structured entity.



### Layer 3: A Contribution Agreement

Every match between an expat and an initiative must generate a signed agreement in some form.

The agreement template should contain:
- What the expat commits to (from the contribution record)
- Timeline
- What constitutes "done" or a successfully finished contribution
- How disputes are handled
- Intellectual Property/ownership clause for any work product

> Disclaimer LLM was harmed in the making of this article. 

<img src="/assets/img/2026-03-25-leadplatform/cat1.jpg" />