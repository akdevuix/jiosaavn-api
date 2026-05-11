import { handle } from 'hono/netlify'
import { app } from '../../src/app'

export default handle(app)
