import { serve } from '@hono/node-server'
import { app } from './src/app'

const port = 3001
serve({ fetch: app.fetch, port }, () => {
  console.log(`Test server running at http://localhost:${port}`)
})
