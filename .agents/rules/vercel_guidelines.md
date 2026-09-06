# Vercel Integration & Deployment Guidelines

## Overview
This project is configured with the official **Vercel AI Plugin** and **Vercel MCP Server** to provide deployment workflows, project inspections, and ecosystem intelligence.

## Vercel MCP Server
- **Endpoint**: `https://mcp.vercel.com`
- **Capabilities**:
  - Search official Vercel documentation
  - Inspect deployments, build traces, and status
  - Fetch and analyze project runtime / build logs
  - Query web analytics and project configuration

## Flutter Web Deployment on Vercel
When deploying Flutter web applications to Vercel:
- **Build Output**: `build/web` (generated via `flutter build web --release`).
- **Configuration**: Use `vercel.json` at the root with SPA rewrites (`/(.*) -> /index.html`) to prevent 404 errors on deep routes.
- **Commands**:
  - Preview deploy: `vercel`
  - Production deploy: `vercel --prod`
  - Inspect project & logs: `vercel inspect <deployment-url>`
  - Environment variables: `vercel env pull` / `vercel env add`
