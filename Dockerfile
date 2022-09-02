ARG centos=7.9.2009
FROM aursu/rpmbuild:${centos}-build-gcc8

USER root
RUN yum -y install \
        doxygen \
        python3 \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "icu.spec"]
CMD ["-ba"]
