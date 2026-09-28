#!/bin/ash

PIDFILE="/tmp/nmap_loop.pid"
LOGFILE="/tmp/nmap_loop.log"
NETWORK="192.168.10.1/32"
INTERVAL=5

start_loop() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "El proceso ya está ejecutándose (PID=$PID)"
            exit 1
        fi
    fi

    echo "Iniciando loop de nmap..."

    (
        while true
        do
            echo "===== $(date) =====" >> "$LOGFILE"
            nmap -sn "$NETWORK" >> "$LOGFILE" 2>&1
            sleep "$INTERVAL"
        done
    ) &

    echo $! > "$PIDFILE"

    echo "Loop iniciado. PID=$(cat $PIDFILE)"
}

stop_loop() {
    if [ ! -f "$PIDFILE" ]; then
        echo "No existe PID registrado."
        exit 1
    fi

    PID=$(cat "$PIDFILE")

    if kill "$PID" 2>/dev/null; then
        rm -f "$PIDFILE"
        echo "Loop detenido."
    else
        echo "No se pudo detener el proceso."
        rm -f "$PIDFILE"
    fi
}

status_loop() {
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")

        if kill -0 "$PID" 2>/dev/null; then
            echo "Loop en ejecución (PID=$PID)"
            exit 0
        fi
    fi

    echo "Loop detenido"
}

case "$1" in
    start)
        start_loop
        ;;
    stop)
        stop_loop
        ;;
    status)
        status_loop
        ;;
    *)
        echo "Uso: $0 {start|stop|status}"
        exit 1
        ;;
esac

