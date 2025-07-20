# Load music playlist
music = playlist("playlist.txt")

# Load jingles and insert every ~10 songs
jingles = playlist("jingles.txt")
with_jingles = random(weights=[10,1], [music, jingles])

# Normalize and crossfade
normalized = normalize(with_jingles)
crossfaded = crossfade(normalized)

# Live DJ stream (fallible)
live_dj = fallback([input.http("http://localhost:8001/live.mp3"), blank()])

# Use fallback to ensure reliability
radio = fallback(track_sensitive=false, [live_dj, crossfaded])

# Output stream (radio is now reliable)
output.icecast(%mp3,
  host = "localhost",
  port = 8000,
  password = "hackme",
  mount = "stream.mp3",
  name = "MyRadio Station",
  description = "24x7 AutoDJ + Live DJ",
  url = "http://localhost:8000",
  genre = "Mixed",
  radio)

