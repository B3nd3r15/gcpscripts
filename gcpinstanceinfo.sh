#!/bin/bash

#################################################################################################################
#
#       NAME: gcpinstanceinfo.sh
#
#       AUTHOR:  B3nd3r15
#
#       SUPPORT:  please post issue on github.
#
#       DESCRIPTION:  Gets all of the instances from all of your projects.
#
#       License: GPL-3.0
#       https://github.com/B3nd3r15/linuxscripts/blob/master/LICENSE
#
#################################################################################################################
#
#       ASSUMPTIONS: Script is run manually, user needs to have projects in gcp with instances to pull info.
#                    Gcloud sdk needs to be installed on the local machine or ran from your console instance.
#
#       INSTALL LOCATION: Anywhere on your local device or from the GCP console instance.
#
#################################################################################################################
#
#       Command(s): N/A
#
#################################################################################################################
#
#    Version      AUTHOR      DATE          COMMENTS
#                 ------      ----          --------
#  VER 0.1.0      B3nd3r      2020/08/05    Initial creation and release.
#
#################################################################################################################


# Header row for the CSV output
echo "Project ID,Instance Name,Status,Zone,Instance Size,Internal IP,External IP, Creation Timestamp (UTC)"

# for every project in the list get the required details. Remove CSV header from the gcloud output. Add the project id to the beginning of each row
for project in  $(gcloud projects list --format="value(projectId)")
do
        gcloud compute instances list --format="csv[no-heading](name,status,zone.basename(),machineType.machine_type().basename():label=Machine_Type,networkInterfaces[].networkIP.notnull().list():label=INTERNAL_IP,networkInterfaces[].accessConfigs[0].natIP.notnull().list():label=EXTERNAL_IP,creationTimestamp.date(tz=UTC))" --project $project | sed "s/^/$project,/"
done