# Deployment Guide - JioSaavn API (Serverless)

## Quick Start

### Option 1: Deploy via Vercel CLI

```bash
# Install Vercel CLI (if not already installed)
npm i -g vercel

# Navigate to project directory
cd jiosaavn-api-vercel

# Login to Vercel
vercel login

# Deploy
vercel

# Deploy to production
vercel --prod
```

### Option 2: Deploy via Vercel Dashboard

1. Push your code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Click "Add New Project"
4. Import your GitHub repository
5. Click "Deploy"

### Option 3: Deploy via Netlify

1. Push your code to GitHub
2. Import the repository into Netlify
3. Set build command to `npm run build`
4. Leave the publish directory empty
5. Deploy

### Option 4: Deploy via Cloudflare

Cloudflare Pages:

1. Import the repository into Cloudflare Pages
2. Set build command to `npm run build`
3. Set build output directory to `dist`
4. Deploy

Cloudflare Workers:

1. Keep `worker.ts` as the entrypoint
2. Deploy with Wrangler using `wrangler.jsonc`

## Project Structure

```
jiosaavn-api-vercel/
├── api/
│   └── [[...routes]].ts      # Vercel serverless entry point
├── src/
│   ├── app.ts                # Hono app configuration
│   ├── common/               # Shared utilities
│   │   ├── constants/        # API endpoints, user agents
│   │   ├── enums/            # Context enums
│   │   ├── helpers/          # Fetch, link helpers
│   │   ├── models/           # Data models
│   │   └── types/            # TypeScript types
│   ├── modules/              # Feature modules
│   │   ├── songs/            # Song endpoints
│   │   ├── albums/           # Album endpoints
│   │   ├── artists/          # Artist endpoints
│   │   ├── playlists/        # Playlist endpoints
│   │   └── search/           # Search endpoints
│   └── pages/                # Home page
├── package.json
├── tsconfig.json
├── vercel.json
└── README.md
```

## Configuration Files

### vercel.json

```json
{
  "rewrites": [
    { "source": "/(.*)", "destination": "/api" }
  ],
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        { "key": "Access-Control-Allow-Origin", "value": "*" },
        { "key": "Access-Control-Allow-Headers", "value": "*" },
        { "key": "Access-Control-Allow-Methods", "value": "GET, OPTIONS" },
        { "key": "Cache-Control", "value": "s-maxage=300, stale-while-revalidate" }
      ]
    }
  ]
}
```

### package.json

Key dependencies:
- `hono` - Web framework
- `@hono/zod-openapi` - OpenAPI support
- `@hono/zod-validator` - Request validation
- `@scalar/hono-api-reference` - API documentation UI
- `node-forge` - Decryption for download links
- `zod` - Schema validation

## Environment Variables

No environment variables required! The app works out of the box.

## API Endpoints

### Base URL
After deployment, your API will be available at:
```
https://your-project.vercel.app
```

### Available Endpoints

#### Songs
- `GET /api/songs?ids=3IoDK8qI,4IoDK8qI` - Get songs by IDs
- `GET /api/songs?link=https://www.jiosaavn.com/song/houdini/OgwhbhtDRwM` - Get song by link
- `GET /api/songs/{id}` - Get song by ID
- `GET /api/songs/{id}/suggestions?limit=10` - Get song suggestions

#### Albums
- `GET /api/albums?id=23241654` - Get album by ID
- `GET /api/albums?link=https://www.jiosaavn.com/album/future-nostalgia/ITIyo-GDr7A_` - Get album by link

#### Artists
- `GET /api/artists?id=1274170` - Get artist by ID
- `GET /api/artists?link=https://www.jiosaavn.com/artist/dua-lipa-songs/r-OWIKgpX2I_` - Get artist by link
- `GET /api/artists/{id}/songs` - Get artist's songs
- `GET /api/artists/{id}/albums` - Get artist's albums

#### Playlists
- `GET /api/playlists?id=82914609` - Get playlist by ID
- `GET /api/playlists?link=https://www.jiosaavn.com/featured/its-indie-english/AMoxtXyKHoU_` - Get playlist by link

#### Search
- `GET /api/search?query=Imagine+Dragons` - Global search
- `GET /api/search/songs?query=Believer` - Search songs
- `GET /api/search/albums?query=Evolve` - Search albums
- `GET /api/search/artists?query=Adele` - Search artists
- `GET /api/search/playlists?query=Indie` - Search playlists

#### Documentation
- `GET /docs` - Interactive API documentation
- `GET /swagger` - OpenAPI/Swagger JSON spec

## Example Usage

### Using cURL

```bash
# Search for songs
curl "https://your-project.vercel.app/api/search/songs?query=Believer"

# Get song by ID
curl "https://your-project.vercel.app/api/songs/3IoDK8qI"

# Get album by ID
curl "https://your-project.vercel.app/api/albums?id=23241654"
```

### Using JavaScript/TypeScript

```typescript
const response = await fetch('https://your-project.vercel.app/api/search/songs?query=Believer')
const data = await response.json()
console.log(data)
```

### Using Python

```python
import requests

response = requests.get('https://your-project.vercel.app/api/search/songs?query=Believer')
data = response.json()
print(data)
```

## Response Format

All endpoints return JSON in the following format:

```json
{
  "success": true,
  "data": { ... }
}
```

## Troubleshooting

### Build Errors

If you encounter build errors:

1. Make sure Node.js version is 18.x or higher
2. Delete `node_modules` and `package-lock.json`
3. Run `npm install` again
4. Run `npm run build` locally first

### Runtime Errors

If the API returns errors:

1. Check Vercel logs in the dashboard
2. Verify the API endpoint URL is correct
3. Check if JioSaavn API is accessible

### CORS Issues

The app includes CORS headers by default. If you still face CORS issues:

1. Check your browser console for specific errors
2. Verify the `vercel.json` headers configuration
3. Make sure you're using HTTPS (Vercel provides this by default)

## Performance Tips

1. **Caching**: The app includes cache headers (300s) for better performance
2. **Edge Functions**: Vercel automatically deploys to edge locations
3. **Cold Starts**: First request may be slower due to cold start, subsequent requests are faster

## Monitoring

Vercel provides built-in monitoring:

1. Go to your project dashboard
2. Click on "Analytics" for usage metrics
3. Click on "Logs" for real-time logs
4. Click on "Functions" for function performance

## Custom Domain

To use a custom domain:

1. Go to your project settings in Vercel
2. Click on "Domains"
3. Add your custom domain
4. Update DNS records as instructed

## Updates

To update the API:

1. Make changes to your code
2. Commit and push to GitHub
3. Vercel will automatically deploy on push
4. Or use `vercel --prod` to deploy manually

## Support

For issues or questions:
- Check the [GitHub Issues](https://github.com/akdevuix/jiosaavn-api/issues)
- Review the [API Documentation](https://your-project.vercel.app/docs)

## License

MIT License - Feel free to use and modify as needed.
