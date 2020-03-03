TOPDIR="${PWD}"

echo "COMMON POST IMAGE script: starting..."

# enable tracing and exit on errors
set -x -e

BR2_LRD_PRODUCT="$(sed -n 's,^BR2_DEFCONFIG=".*/\(.*\)_defconfig"$,\1,p' ${BR2_CONFIG})"

cp "${BINARIES_DIR}/uImage."* "${BINARIES_DIR}/kernel.bin"
cp "${BINARIES_DIR}/rootfs.ubi" "${BINARIES_DIR}/rootfs.bin"
cp "${BINARIES_DIR}/at91bootstrap.bin" "${BINARIES_DIR}/at91bs.bin"

cp board/laird/rootfs-additions-common/usr/sbin/fw_select "${BINARIES_DIR}/"
cp board/laird/rootfs-additions-common/usr/sbin/fw_update "${BINARIES_DIR}/"

[ -z "${LAIRD_FW_TXT_URL}" ] && \
	LAIRD_FW_TXT_URL="http://$(hostname)/${BR2_LRD_PRODUCT}"

[ -n "${VERSION}" ] && RELEASE_SUFFIX="-${VERSION}"

cd "${BINARIES_DIR}"
${TOPDIR}/board/laird/mkfwtxt.sh "${LAIRD_FW_TXT_URL}"
${TOPDIR}/board/laird/mkfwusi.sh

if [ ${BR2_LRD_PLATFORM} == "wb45n" ]; then
	word=$(stat -c "%s" ${BINARIES_DIR}/kernel.bin)
	if [ $word -gt 2359296 ]
	then
		echo "kernel size exceeded 18 block limit, failed"
		exit 1
	fi
fi

if [ ${BR2_LRD_PLATFORM} == "wb50n" ]; then
	word=$(stat -c "%s" ${BINARIES_DIR}/kernel.bin)
	if [ $word -gt 4980736 ]
	then
		echo "kernel size exceeded 38 block limit, failed"
		exit 1
	fi
fi

tar -cjf "${BR2_LRD_PRODUCT}-laird${RELEASE_SUFFIX}.tar.bz2" \
	--owner=0 --group=0 --numeric-owner \
	at91bs.bin u-boot.bin kernel.bin rootfs.bin \
	fw_update fw_select fw_usi fw.txt \
	$(ls userfs.bin sqroot.bin prep_nand_for_update 2>/dev/null)

echo "COMMON POST IMAGE script: done."
