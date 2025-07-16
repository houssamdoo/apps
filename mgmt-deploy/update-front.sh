#!/bin/bash

IMAGE_NAME="agb-frontend:v3.0"
TAR_FILE="agb-frontend.v3.0.tar.gz"
STACK_FILE="docker-compose.yaml"
REMOTE_USER="ubuntu"
REMOTE_HOSTS=("15.15.15.31" "15.15.15.32")

cd /home/ubuntu/apps/money-transfer-app/frontend/
echo "#############################################"
echo "[1] Building Docker image..."
echo "#############################################"
docker build -t $IMAGE_NAME .

# 2. Save image to tar.gz

echo
echo
echo "#############################################"
echo "[2] Saving image to $TAR_FILE..."
echo "#############################################"
docker save $IMAGE_NAME | gzip > $TAR_FILE

echo
echo
echo "#############################################"
# 3. Send image to remote VMs
for HOST in "${REMOTE_HOSTS[@]}"; do
    echo "[3] Copying image to $HOST..."
    rsync -ah --inplace --partial --info=progress2 $TAR_FILE ${REMOTE_USER}@${HOST}:/tmp/
#    scp $TAR_FILE ${REMOTE_USER}@${HOST}:/tmp/
done

echo
echo
echo "#############################################"
# 4. Load image remotely
for HOST in "${REMOTE_HOSTS[@]}"; do
    echo "[4] Loading image on $HOST..."
    ssh ${REMOTE_USER}@${HOST} "gunzip -c /tmp/$TAR_FILE | docker load"
done

## 5. Deploy the stack on the first host (manager)
#MANAGER_HOST=${REMOTE_HOSTS[0]}
#echo "[5] Deploying stack on manager $MANAGER_HOST..."
echo
echo
echo
echo "#############################################"
echo "[5] Deploying stack on manager $MANAGER_HOST..."
echo
cd /home/ubuntu/apps/mgmt-deploy/frontend
#docker service rm agb-core_frontend agb-core_frontend
docker service update --force agb-core_frontend
#docker stack deploy --compose-file docker-compose.yaml agb-core
#scp $STACK_FILE ${REMOTE_USER}@${MANAGER_HOST}:/tmp/
#ssh ${REMOTE_USER}@${MANAGER_HOST} "docker stack deploy -c /tmp/$STACK_FILE mystack"
#
#echo "✅ Done."

