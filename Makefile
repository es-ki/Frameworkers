.PHONY: dev

s:
	rm -f /app/tmp/pids/server.pid && rails s -b 0.0.0.0 -p 3000