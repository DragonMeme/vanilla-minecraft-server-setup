ARG JAVA_VERSION=8
FROM eclipse-temurin:${JAVA_VERSION}-jre-alpine

# Include udev lib for minecraft server functionality.
RUN apk update && apk upgrade && apk add eudev-libs

ARG UNAME=root
ARG GNAME=root
ARG UID=1000
ARG GID=1000

# Create a group and a system user in a single RUN instruction to reduce image layers
RUN addgroup -S -g $GID $GNAME && adduser -S -D -u $UID -G $GNAME $UNAME

USER ${UNAME}
WORKDIR /home/${UNAME}

CMD ["java", "-jar", "server.jar", "nogui"]
