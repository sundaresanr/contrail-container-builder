#!/bin/bash

source /common.sh

if [[ ! -d /host/usr/bin ]]; then
  echo "ERROR: there is no mount /host/usr/bin from Host's /usr/bin. Utility contrail-status could not be created."
  exit 1
fi

if [[ -z "$CONTRAIL_STATUS_IMAGE" ]]; then
  echo 'ERROR: variable $CONTRAIL_STATUS_IMAGE is not defined. Utility contrail-status could not be created.'
  exit 1
fi

if [ -f /host/usr/bin/contrail-status ]; then
   exit
fi

# cause multiple instances can generate this at one moment - this operation should be atomic
tmp_file=/host/usr/bin/contrail-status.tmp
cat > $tmp_file << EOM
#!/bin/bash -e
docker run --rm --name contrail-status -v /var/run/docker.sock:/var/run/docker.sock --pid host --net host --privileged ${CONTRAIL_STATUS_IMAGE}
EOM

chmod 755 $tmp_file
mv -f $tmp_file /host/usr/bin/contrail-status
