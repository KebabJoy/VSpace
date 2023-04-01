FROM solr:8.11.1

# Set environment variables
ENV SOLR_CORE production
ENV SOLR_HOME /opt/solr/server/solr
ENV SOLR_HEAP 512m

# Create a new Solr core
RUN mkdir -p $SOLR_HOME/$SOLR_CORE
COPY schema.xml $SOLR_HOME/$SOLR_CORE/conf/schema.xml
COPY solrconfig.xml $SOLR_HOME/$SOLR_CORE/conf/solrconfig.xml

# Expose the Solr port
EXPOSE 8983

# Start the Solr server
CMD ["solr-foreground"]
