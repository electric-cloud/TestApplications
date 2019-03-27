
project 'Microservices Demo', {
    resourceName = null
    workspaceName = null

    environment 'Amazon ECS', {
        description = '''Amazon EC2 Container Service (ECS) is a highly scalable, high performance container management service that supports Docker containers and allows you to easily run applications on a managed cluster of Amazon EC2 instances.
https://aws.amazon.com/ecs/?nc1=h_ls'''
        environmentEnabled = '1'
        projectName = 'Microservices Demo'
        reservationRequired = '0'
        rollingDeployEnabled = null
        rollingDeployType = null

        cluster 'Amazon ECS', {
            environmentName = 'Amazon ECS'
            pluginKey = null
            pluginProjectName = getPlugin(pluginName: 'EC-AmazonECS').projectName
            providerClusterName = 'qe-ecs-cluster'
            providerProjectName = null
            provisionParameter = [
                    'AMI': 'ami-21f9ba41',
                    'availabilityZones': 'us-west-1b',
                    'clusterName': 'qe-ecs-cluster',
                    'config': 'ecsConfig',
                    'desiredCapacity': '1',
                    'instanceType': 't2.medium',
                    'keyName': 'DemoKeyPair',
                    'maximumSize': '2',
                    'minimumSize': '1',
                    'securityGroups': 'sg-798dae1d',
                    'vpcSubnetIds': 'subnet-fcb353a4',
            ]
            provisionProcedure = 'Provision Cluster'
        }
    }

    environment 'AzureContainerService', {
        description = ''
        environmentEnabled = '1'
        projectName = 'Microservices Demo'
        reservationRequired = '0'
        rollingDeployEnabled = null
        rollingDeployType = null

        cluster 'cluster', {
            environmentName = 'AzureContainerService'
            pluginKey = 'EC-AzureContainerService'
            pluginProjectName = null
            providerClusterName = null
            providerProjectName = null
            provisionParameter = [
                    'adminUsername': 'ecloudadmin',
                    'agentPoolCount': '2',
                    'agentPoolDnsPrefix': 'flowqeagent',
                    'agentPoolName': 'agentflowqe',
                    'agentPoolVmsize': 'Standard_D1',
                    'clusterName': 'flowqe-test-cluster',
                    'clusterPrepTime': '120',
                    'clusterWaitime': '20',
                    'config': 'acsConf',
                    'masterCount': '1',
                    'masterDnsPrefix': 'flowqe',
                    'masterFqdn': 'masterflowqe',
//                    'masterVmsize': 'Standard_D1',
                    'masterZone': 'eastus',
                    'orchestratorType': 'kubernetes',
                    'resourceGroupName': 'flowqe-test-resource-group',
            ]
            provisionProcedure = 'Provision Cluster'
        }
    }

    environment 'Docker', {
        environmentEnabled = '1'
        projectName = 'Microservices Demo'
        reservationRequired = '0'
        rollingDeployEnabled = null
        rollingDeployType = null

        cluster 'cluster', {
            environmentName = 'Docker'
            pluginKey = 'EC-Docker'
            pluginProjectName = null
            providerClusterName = null
            providerProjectName = null
            provisionParameter = [
                    'config': 'dockerConf',
            ]
            provisionProcedure = 'Check Cluster'
        }
    }

    environment 'K8S', {
        environmentEnabled = '1'
        projectName = 'Microservices Demo'
        reservationRequired = '0'
        rollingDeployEnabled = null
        rollingDeployType = null

        cluster 'cluster', {
            environmentName = 'K8S'
            pluginKey = 'EC-Kubernetes'
            pluginProjectName = null
            providerClusterName = null
            providerProjectName = null
            provisionParameter = [
                    'config': 'k8sConfig',
            ]
            provisionProcedure = 'Check Cluster'
        }
    }

    environment 'Openshift', {
        description = ''
        environmentEnabled = '1'
        projectName = 'Microservices Demo'
        reservationRequired = '0'
        rollingDeployEnabled = null
        rollingDeployType = null

        cluster 'cluster', {
            environmentName = 'Openshift'
            pluginKey = 'EC-OpenShift'
            pluginProjectName = null
            providerClusterName = null
            providerProjectName = null
            provisionParameter = [
                    'config': 'openshiftConf',
                    'project': 'flowqe-test-project',
            ]
            provisionProcedure = 'Check Cluster'
        }
    }

    procedure 'Undeploy Service (microservice version)', {
        description = ''
        jobNameTemplate = ''
        resourceName = ''
        timeLimit = ''
        timeLimitUnits = 'minutes'
        workspaceName = ''

        formalParameter 'deployOn', defaultValue: 'k8s', {
            description = ''
            expansionDeferred = '0'
            label = null
            orderIndex = null
            required = '1'
            type = 'entry'
        }

        step 'Openshift', {
            description = ''
            alwaysRun = '0'
            broadcast = '0'
            command = null
            condition = '$[deployOn]==\'openshift\''
            errorHandling = 'failProcedure'
            exclusiveMode = 'none'
            logFileName = null
            parallel = '0'
            postProcessor = null
            precondition = ''
            releaseMode = 'none'
            resourceName = ''
            shell = null
            subprocedure = 'Undeploy Service'
            subproject = '/plugins/EC-OpenShift/project'
            timeLimit = ''
            timeLimitUnits = 'minutes'
            workingDirectory = null
            workspaceName = ''
            actualParameter 'applicationName', ''
            actualParameter 'applicationRevisionId', ''
            actualParameter 'clusterName', 'cluster'
            actualParameter 'environmentName', '$[/myEnvironment]'
            actualParameter 'envProjectName', '$[/myEnvironment/projectName]'
            actualParameter 'serviceEntityRevisionId', ''
            actualParameter 'serviceName', '$[/myService]'
            actualParameter 'serviceProjectName', '$[/myService/projectName]'
        }

        step 'K8S', {
            description = ''
            alwaysRun = '0'
            broadcast = '0'
            command = null
            condition = '$[deployOn]==\'k8s\''
            errorHandling = 'failProcedure'
            exclusiveMode = 'none'
            logFileName = null
            parallel = '0'
            postProcessor = null
            precondition = ''
            releaseMode = 'none'
            resourceName = ''
            shell = null
            subprocedure = 'Undeploy Service'
            subproject = '/plugins/EC-Kubernetes/project'
            timeLimit = ''
            timeLimitUnits = 'minutes'
            workingDirectory = null
            workspaceName = ''
            actualParameter 'applicationName', ''
            actualParameter 'applicationRevisionId', ''
            actualParameter 'clusterName', 'cluster'
            actualParameter 'environmentName', '$[/myEnvironment]'
            actualParameter 'envProjectName', '$[/myEnvironment/projectName]'
            actualParameter 'serviceEntityRevisionId', ''
            actualParameter 'serviceName', '$[/myService]'
            actualParameter 'serviceProjectName', '$[/myService/projectName]'
        }

        step 'Docker', {
            description = ''
            alwaysRun = '0'
            broadcast = '0'
            command = null
            condition = '$[/javascript \'$[deployOn]\'==\'docker\']'
            errorHandling = 'failProcedure'
            exclusiveMode = 'none'
            logFileName = null
            parallel = '0'
            postProcessor = null
            precondition = ''
            releaseMode = 'none'
            resourceName = ''
            shell = null
            subprocedure = 'Undeploy Service'
            subproject = '/plugins/EC-Kubernetes/project'
            timeLimit = ''
            timeLimitUnits = 'minutes'
            workingDirectory = null
            workspaceName = ''
            actualParameter 'applicationName', ''
            actualParameter 'applicationRevisionId', ''
            actualParameter 'clusterName', 'cluster'
            actualParameter 'environmentName', '$[/myEnvironment]'
            actualParameter 'envProjectName', '$[/myEnvironment/projectName]'
            actualParameter 'serviceEntityRevisionId', ''
            actualParameter 'serviceName', '$[/myService]'
            actualParameter 'serviceProjectName', '$[/myService/projectName]'
        }

        // Custom properties

        property 'ec_customEditorData', {

            // Custom properties

            property 'parameters', {

                // Custom properties

                property 'deployOn', {

                    // Custom properties
                    formType = 'standard'
                }
            }
        }
    }

    application 'MotorBike StoreFront', {
        description = ''

        service 'store-backend', {
            applicationName = 'MotorBike StoreFront'
            defaultCapacity = null
            maxCapacity = null
            minCapacity = null
            volume = null

            container 'motorbikeMS', {
                description = ''
                applicationName = 'MotorBike StoreFront'
                command = null
                cpuCount = '0.25'
                cpuLimit = '1'
                entryPoint = null
                imageName = 'ecdocker/bike-springboot-hsql'
                imageVersion = 'v1.0'
                memoryLimit = null
                memorySize = '512'
                registryUri = null
                serviceName = 'store-backend'
                volumeMount = null

                port 'p1', {
                    applicationName = 'MotorBike StoreFront'
                    containerName = 'motorbikeMS'
                    containerPort = '8070'
                    projectName = 'Microservices Demo'
                    serviceName = 'store-backend'
                }
            }

            port '_servicep1motorbikeMS01511519367623', {
                applicationName = 'MotorBike StoreFront'
                listenerPort = '8080'
                projectName = 'Microservices Demo'
                serviceName = 'store-backend'
                subcontainer = 'motorbikeMS'
                subport = 'p1'
            }

            process 'Deploy', {
                applicationName = null
                processType = 'DEPLOY'
                serviceName = 'store-backend'
                smartUndeployEnabled = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                processStep 'deployService', {
                    afterLastRetry = null
                    alwaysRun = '0'
                    applicationTierName = null
                    componentRollback = null
                    dependencyJoinType = null
                    errorHandling = 'failProcedure'
                    instruction = null
                    notificationEnabled = null
                    notificationTemplate = null
                    processStepType = 'service'
                    retryCount = null
                    retryInterval = null
                    retryType = null
                    rollbackSnapshot = null
                    rollbackType = null
                    rollbackUndeployProcess = null
                    skipRollbackIfUndeployFails = null
                    smartRollback = null
                    subcomponent = null
                    subcomponentApplicationName = null
                    subcomponentProcess = null
                    subprocedure = null
                    subproject = null
                    subservice = null
                    subserviceProcess = null
                    timeLimitUnits = null
                    workingDirectory = null
                    workspaceName = null
                }
            }

            process 'Undeploy', {
                applicationName = null
                processType = 'UNDEPLOY'
                serviceName = 'store-backend'
                smartUndeployEnabled = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                processStep 'Undeploy', {
                    afterLastRetry = null
                    alwaysRun = '0'
                    applicationTierName = null
                    componentRollback = null
                    dependencyJoinType = 'and'
                    errorHandling = 'abortJob'
                    instruction = null
                    notificationEnabled = null
                    notificationTemplate = null
                    processStepType = 'service'
                    retryCount = null
                    retryInterval = null
                    retryType = null
                    rollbackSnapshot = null
                    rollbackType = null
                    rollbackUndeployProcess = null
                    skipRollbackIfUndeployFails = null
                    smartRollback = null
                    subcomponent = null
                    subcomponentApplicationName = null
                    subcomponentProcess = null
                    subprocedure = null
                    subproject = null
                    subservice = 'store-backend'
                    subserviceProcess = null
                    timeLimitUnits = null
                    workingDirectory = null
                    workspaceName = null
                }
            }
        }

        service 'store-frontend', {
            applicationName = 'MotorBike StoreFront'
            defaultCapacity = null
            maxCapacity = null
            minCapacity = null
            volume = null

            container 'nodejsapp', {
                description = ''
                applicationName = 'MotorBike StoreFront'
                command = null
                cpuCount = '0.5'
                cpuLimit = '1'
                entryPoint = null
                imageName = 'ecdocker/bike-nodejs'
                imageVersion = 'v3.0'
                memoryLimit = null
                memorySize = '1024'
                registryUri = null
                serviceName = 'store-frontend'
                volumeMount = null

                environmentVariable 'SERVICE_PORT', {
                    type = 'string'
                    value = '8080'
                }

                environmentVariable 'SERVICE_URL', {
                    type = 'string'
                    value = 'store-backend'
                }

                port 'p2', {
                    applicationName = 'MotorBike StoreFront'
                    containerName = 'nodejsapp'
                    containerPort = '5000'
                    projectName = 'Microservices Demo'
                    serviceName = 'store-frontend'
                }
            }

            port '_servicep2nodejsapp01511519376263', {
                applicationName = 'MotorBike StoreFront'
                listenerPort = '5000'
                projectName = 'Microservices Demo'
                serviceName = 'store-frontend'
                subcontainer = 'nodejsapp'
                subport = 'p2'
            }

            process 'Deploy', {
                applicationName = null
                processType = 'DEPLOY'
                serviceName = 'store-frontend'
                smartUndeployEnabled = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                processStep 'deployService', {
                    afterLastRetry = null
                    alwaysRun = '0'
                    applicationTierName = null
                    componentRollback = null
                    dependencyJoinType = null
                    errorHandling = 'failProcedure'
                    instruction = null
                    notificationEnabled = null
                    notificationTemplate = null
                    processStepType = 'service'
                    retryCount = null
                    retryInterval = null
                    retryType = null
                    rollbackSnapshot = null
                    rollbackType = null
                    rollbackUndeployProcess = null
                    skipRollbackIfUndeployFails = null
                    smartRollback = null
                    subcomponent = null
                    subcomponentApplicationName = null
                    subcomponentProcess = null
                    subprocedure = null
                    subproject = null
                    subservice = null
                    subserviceProcess = null
                    timeLimitUnits = null
                    workingDirectory = null
                    workspaceName = null
                }
            }

            process 'Undeploy', {
                applicationName = null
                processType = 'UNDEPLOY'
                serviceName = 'store-frontend'
                smartUndeployEnabled = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                processStep 'Undeploy', {
                    afterLastRetry = null
                    alwaysRun = '0'
                    applicationTierName = null
                    componentRollback = null
                    dependencyJoinType = 'and'
                    errorHandling = 'abortJob'
                    instruction = null
                    notificationEnabled = null
                    notificationTemplate = null
                    processStepType = 'service'
                    retryCount = null
                    retryInterval = null
                    retryType = null
                    rollbackSnapshot = null
                    rollbackType = null
                    rollbackUndeployProcess = null
                    skipRollbackIfUndeployFails = null
                    smartRollback = null
                    subcomponent = null
                    subcomponentApplicationName = null
                    subcomponentProcess = null
                    subprocedure = null
                    subproject = null
                    subservice = 'store-frontend'
                    subserviceProcess = null
                    timeLimitUnits = null
                    workingDirectory = null
                    workspaceName = null
                }
            }
        }

        process 'Deploy', {
            applicationName = 'MotorBike StoreFront'
            processType = 'OTHER'
            serviceName = null
            smartUndeployEnabled = null
            timeLimitUnits = null
            workingDirectory = null
            workspaceName = null

            formalParameter 'ec_enforceDependencies', defaultValue: '0', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            formalParameter 'ec_store-backend-run', defaultValue: '1', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            formalParameter 'ec_store-frontend-run', defaultValue: '1', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            processStep 'Deploy store-backend', {
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = 'and'
                errorHandling = 'abortJob'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'process'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = 'MotorBike StoreFront'
                subcomponentProcess = null
                subprocedure = null
                subproject = null
                subservice = 'store-backend'
                subserviceProcess = 'Deploy'
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            processStep 'Deploy store-frontend', {
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = 'and'
                errorHandling = 'abortJob'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'process'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = 'MotorBike StoreFront'
                subcomponentProcess = null
                subprocedure = null
                subproject = null
                subservice = 'store-frontend'
                subserviceProcess = 'Deploy'
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            processDependency 'Deploy store-backend', targetProcessStepName: 'Deploy store-frontend', {
                branchCondition = null
                branchConditionName = null
                branchConditionType = null
                branchType = 'SUCCESS'
            }

            // Custom properties

            property 'ec_deploy', {

                // Custom properties
                ec_notifierStatus = '0'
            }
        }

        process 'Undeploy', {
            applicationName = 'MotorBike StoreFront'
            processType = 'OTHER'
            serviceName = null
            smartUndeployEnabled = null
            timeLimitUnits = null
            workingDirectory = null
            workspaceName = null

            formalParameter 'ec_enforceDependencies', defaultValue: '0', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            formalParameter 'ec_store-backend-run', defaultValue: '1', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            formalParameter 'ec_store-frontend-run', defaultValue: '1', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            processStep 'Undeploy store-frontend', {
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = 'and'
                errorHandling = 'abortJob'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'process'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = 'MotorBike StoreFront'
                subcomponentProcess = null
                subprocedure = null
                subproject = null
                subservice = 'store-frontend'
                subserviceProcess = 'Undeploy'
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            processStep 'Undeploy store-backend', {
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = 'and'
                errorHandling = 'abortJob'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'process'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = 'MotorBike StoreFront'
                subcomponentProcess = null
                subprocedure = null
                subproject = null
                subservice = 'store-backend'
                subserviceProcess = 'Undeploy'
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            processDependency 'Undeploy store-frontend', targetProcessStepName: 'Undeploy store-backend', {
                branchCondition = null
                branchConditionName = null
                branchConditionType = null
                branchType = 'SUCCESS'
            }

            // Custom properties

            property 'ec_deploy', {

                // Custom properties
                ec_notifierStatus = '0'
            }
        }

        tierMap '1b16a28e-d101-11e7-b861-0050563309ee', {
            applicationName = 'MotorBike StoreFront'
            environmentName = 'K8S'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'

            serviceClusterMapping '1baceeaa-d101-11e7-9da8-0050563309ee', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = '1b16a28e-d101-11e7-b861-0050563309ee'
                volume = null

                serviceMapDetail 'nodejsapp', {
                    serviceMapDetailName = '28ccc458-d101-11e7-b861-0050563309ee'
                    command = null
                    cpuCount = null
                    cpuLimit = null
                    entryPoint = null
                    imageName = null
                    imageVersion = null
                    memoryLimit = null
                    memorySize = null
                    registryUri = null
                    serviceClusterMappingName = '1baceeaa-d101-11e7-9da8-0050563309ee'
                    volumeMount = null
                }
            }

            serviceClusterMapping 'e073baea-d102-11e7-b861-0050563309ee', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = '1b16a28e-d101-11e7-b861-0050563309ee'
                volume = null
            }
        }

        tierMap '1ece998c-df16-11e7-bb73-005056330eab', {
            applicationName = 'MotorBike StoreFront'
            environmentName = 'Docker'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'

            serviceClusterMapping '1f6840a8-df16-11e7-8167-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = '1ece998c-df16-11e7-bb73-005056330eab'
                volume = null
            }

            serviceClusterMapping '2063df38-df16-11e7-b472-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = '1ece998c-df16-11e7-bb73-005056330eab'
                volume = null
            }
        }

        tierMap '346b6f82-df16-11e7-b472-005056330eab', {
            applicationName = 'MotorBike StoreFront'
            environmentName = 'AzureContainerService'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'

            serviceClusterMapping '34d7027f-df16-11e7-a036-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = '346b6f82-df16-11e7-b472-005056330eab'
                volume = null

                serviceMapDetail 'motorbikeMS', {
                    serviceMapDetailName = '02214142-df24-11e7-91ac-005056330eab'
                    command = null
                    cpuCount = null
                    cpuLimit = null
                    entryPoint = null
                    imageName = null
                    imageVersion = null
                    memoryLimit = null
                    memorySize = null
                    registryUri = null
                    serviceClusterMappingName = '34d7027f-df16-11e7-a036-005056330eab'
                    volumeMount = null
                }
            }

            serviceClusterMapping '35ce0ccb-df16-11e7-b472-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = '346b6f82-df16-11e7-b472-005056330eab'
                volume = null
            }
        }

        tierMap 'a2fb5ed7-dfef-11e7-a257-005056330eab', {
            applicationName = 'MotorBike StoreFront'
            environmentName = 'Openshift'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'

            serviceClusterMapping 'a36fa4a7-dfef-11e7-aa46-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = 'a2fb5ed7-dfef-11e7-a257-005056330eab'
                volume = null
            }

            serviceClusterMapping 'a4911a6c-dfef-11e7-99d9-005056330eab', {
                actualParameter = [
                        'requestType': 'update',
                        'routeHostname': '35.202.181.233',
                        'routeName': 'flowqe-motorbike',
                        'routeTargetPort': 'servicep2nodejsapp01511519376263',
                ]
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = null
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = 'a2fb5ed7-dfef-11e7-a257-005056330eab'
                volume = null

                serviceMapDetail 'nodejsapp', {
                    serviceMapDetailName = 'f99468b6-dfef-11e7-99d9-005056330eab'
                    command = null
                    cpuCount = null
                    cpuLimit = null
                    entryPoint = null
                    imageName = null
                    imageVersion = null
                    memoryLimit = null
                    memorySize = null
                    registryUri = null
                    serviceClusterMappingName = 'a4911a6c-dfef-11e7-99d9-005056330eab'
                    volumeMount = null
                }
            }
        }

        // Custom properties

        property 'ec_deploy', {

            // Custom properties
            ec_notifierStatus = '0'
        }
        jobCounter = '9'
    }

    service 'store-frontend', {
        applicationName = null
        defaultCapacity = null
        maxCapacity = null
        minCapacity = null
        volume = null

        container 'nodejsapp', {
            description = ''
            applicationName = null
            command = null
            cpuCount = '0.5'
            cpuLimit = '1'
            entryPoint = null
            imageName = 'ecdocker/bike-nodejs'
            imageVersion = 'v3.0'
            memoryLimit = null
            memorySize = '1024'
            registryUri = null
            serviceName = 'store-frontend'
            volumeMount = null

            environmentVariable 'SERVICE_PORT', {
                type = 'string'
                value = '8080'
            }

            environmentVariable 'SERVICE_URL', {
                type = 'string'
                value = 'store-backend'
            }

            port 'p2', {
                applicationName = null
                containerName = 'nodejsapp'
                containerPort = '5000'
                projectName = 'Microservices Demo'
                serviceName = 'store-frontend'
            }
        }

        environmentMap '08ee370c-dbf1-11e7-9b62-005056330eab', {
            environmentName = 'Openshift'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'
            serviceName = 'store-frontend'

            serviceClusterMapping '09b94f30-dbf1-11e7-a605-005056330eab', {
                actualParameter = [
                        'requestType': 'create',
                        'routeHostname': '35.202.181.233',
                        'routeName': 'flowqe-motorbike',
                        'routePath': '/ui',
                        'routeTargetPort': '_servicep2nodejsapp01511518623774',
                ]
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = '08ee370c-dbf1-11e7-9b62-005056330eab'
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = null
                volume = null

                serviceMapDetail 'nodejsapp', {
                    serviceMapDetailName = 'b062b9f5-dbf5-11e7-8cd3-005056330eab'
                    command = null
                    cpuCount = null
                    cpuLimit = null
                    entryPoint = null
                    imageName = null
                    imageVersion = null
                    memoryLimit = null
                    memorySize = null
                    registryUri = null
                    serviceClusterMappingName = '09b94f30-dbf1-11e7-a605-005056330eab'
                    volumeMount = null
                }
            }
        }

        environmentMap 'a621706f-d0fa-11e7-88f1-0050563309ee', {
            environmentName = 'K8S'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'
            serviceName = 'store-frontend'

            serviceClusterMapping 'caec145e-d0fa-11e7-a939-0050563309ee', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = 'a621706f-d0fa-11e7-88f1-0050563309ee'
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = null
                volume = null
            }
        }

        environmentMap 'e765f283-de74-11e7-acec-005056330eab', {
            environmentName = 'Docker'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'
            serviceName = 'store-frontend'

            serviceClusterMapping 'e8285787-de74-11e7-aad5-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = 'e765f283-de74-11e7-acec-005056330eab'
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-frontend'
                tierMapName = null
                volume = null
            }
        }

        port '_servicep2nodejsapp01511518623774', {
            applicationName = null
            listenerPort = '5000'
            projectName = 'Microservices Demo'
            serviceName = 'store-frontend'
            subcontainer = 'nodejsapp'
            subport = 'p2'
        }

        process 'Deploy', {
            applicationName = null
            processType = 'DEPLOY'
            serviceName = 'store-frontend'
            smartUndeployEnabled = null
            timeLimitUnits = null
            workingDirectory = null
            workspaceName = null

            formalParameter 'ec_enforceDependencies', defaultValue: '0', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            processStep 'deployService', {
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = null
                errorHandling = 'failProcedure'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'service'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = null
                subcomponentProcess = null
                subprocedure = null
                subproject = null
                subservice = null
                subserviceProcess = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            // Custom properties

            property 'ec_deploy', {

                // Custom properties
                ec_notifierStatus = '0'
            }
        }

        process 'Undeploy', {
            applicationName = null
            processType = 'UNDEPLOY'
            serviceName = 'store-frontend'
            smartUndeployEnabled = null
            timeLimitUnits = null
            workingDirectory = null
            workspaceName = null

            formalParameter 'deployOn', defaultValue: null, {
                description = '''Possible values:
- k8s
- openshift'''
                expansionDeferred = '0'
                label = 'Deploy On'
                orderIndex = '1'
                required = '1'
                type = 'entry'
            }

            formalParameter 'ec_enforceDependencies', defaultValue: '0', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            processStep 'Undeploy', {
                actualParameter = [
                        'deployOn': '$[deployOn]',
                ]
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = 'and'
                errorHandling = 'abortJob'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'procedure'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = null
                subcomponentProcess = null
                subprocedure = 'Undeploy Service (microservice version)'
                subproject = 'Microservices Demo'
                subservice = null
                subserviceProcess = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            // Custom properties

            property 'ec_deploy', {

                // Custom properties
                ec_notifierStatus = '0'
            }
        }

        // Custom properties

        property 'ec_deploy', {

            // Custom properties
            ec_notifierStatus = '0'
        }
        jobCounter = '10'
    }

    service 'store-backend', {
        applicationName = null
        defaultCapacity = null
        maxCapacity = null
        minCapacity = null
        volume = null

        container 'motorbikeMS', {
            description = ''
            applicationName = null
            command = null
            cpuCount = '0.25'
            cpuLimit = '1'
            entryPoint = null
            imageName = 'ecdocker/bike-springboot-hsql'
            imageVersion = 'v1.0'
            memoryLimit = null
            memorySize = '512'
            registryUri = null
            serviceName = 'store-backend'
            volumeMount = null

            port 'p1', {
                applicationName = null
                containerName = 'motorbikeMS'
                containerPort = '8070'
                projectName = 'Microservices Demo'
                serviceName = 'store-backend'
            }
        }

        environmentMap '9cade870-dbf6-11e7-b098-005056330eab', {
            environmentName = 'Openshift'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'
            serviceName = 'store-backend'

            serviceClusterMapping '9d251406-dbf6-11e7-8cd3-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = '9cade870-dbf6-11e7-b098-005056330eab'
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = null
                volume = null
            }
        }

        environmentMap 'a621706f-d0fa-11e7-88f1-0050563309ee', {
            environmentName = 'K8S'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'
            serviceName = 'store-backend'

            serviceClusterMapping 'caec145e-d0fa-11e7-a939-0050563309ee', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = 'a621706f-d0fa-11e7-88f1-0050563309ee'
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = null
                volume = null

                serviceMapDetail 'motorbikeMS', {
                    serviceMapDetailName = '01f71848-d102-11e7-974e-0050563309ee'
                    command = null
                    cpuCount = null
                    cpuLimit = null
                    entryPoint = null
                    imageName = null
                    imageVersion = null
                    memoryLimit = null
                    memorySize = null
                    registryUri = null
                    serviceClusterMappingName = 'caec145e-d0fa-11e7-a939-0050563309ee'
                    volumeMount = null
                }
            }
        }

        environmentMap 'd2bea00c-de74-11e7-8e3a-005056330eab', {
            environmentName = 'Docker'
            environmentProjectName = 'Microservices Demo'
            projectName = 'Microservices Demo'
            serviceName = 'store-backend'

            serviceClusterMapping 'd352c97f-de74-11e7-b837-005056330eab', {
                clusterName = 'cluster'
                clusterProjectName = null
                defaultCapacity = null
                environmentMapName = 'd2bea00c-de74-11e7-8e3a-005056330eab'
                maxCapacity = null
                minCapacity = null
                serviceName = 'store-backend'
                tierMapName = null
                volume = null
            }
        }

        port '_servicep1motorbikeMS01511518599983', {
            applicationName = null
            listenerPort = '8080'
            projectName = 'Microservices Demo'
            serviceName = 'store-backend'
            subcontainer = 'motorbikeMS'
            subport = 'p1'
        }

        process 'Deploy', {
            applicationName = null
            processType = 'DEPLOY'
            serviceName = 'store-backend'
            smartUndeployEnabled = null
            timeLimitUnits = null
            workingDirectory = null
            workspaceName = null

            formalParameter 'ec_enforceDependencies', defaultValue: '0', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            processStep 'deployService', {
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = null
                errorHandling = 'failProcedure'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'service'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = null
                subcomponentProcess = null
                subprocedure = null
                subproject = null
                subservice = null
                subserviceProcess = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            // Custom properties

            property 'ec_deploy', {

                // Custom properties
                ec_notifierStatus = '0'
            }
        }

        process 'Undeploy', {
            applicationName = null
            processType = 'UNDEPLOY'
            serviceName = 'store-backend'
            smartUndeployEnabled = null
            timeLimitUnits = null
            workingDirectory = null
            workspaceName = null

            formalParameter 'deployOn', defaultValue: null, {
                expansionDeferred = '0'
                label = null
                orderIndex = '1'
                required = '1'
                type = 'entry'
            }

            formalParameter 'ec_enforceDependencies', defaultValue: '0', {
                expansionDeferred = '1'
                label = null
                orderIndex = null
                required = '0'
                type = 'checkbox'
            }

            processStep 'Undeploy', {
                actualParameter = [
                        'deployOn': '$[deployOn]',
                ]
                afterLastRetry = null
                alwaysRun = '0'
                applicationTierName = null
                componentRollback = null
                dependencyJoinType = 'and'
                errorHandling = 'abortJob'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                processStepType = 'procedure'
                retryCount = null
                retryInterval = null
                retryType = null
                rollbackSnapshot = null
                rollbackType = null
                rollbackUndeployProcess = null
                skipRollbackIfUndeployFails = null
                smartRollback = null
                subcomponent = null
                subcomponentApplicationName = null
                subcomponentProcess = null
                subprocedure = 'Undeploy Service (microservice version)'
                subproject = 'Microservices Demo'
                subservice = null
                subserviceProcess = null
                timeLimitUnits = null
                workingDirectory = null
                workspaceName = null

                // Custom properties

                property 'ec_deploy', {

                    // Custom properties
                    ec_notifierStatus = '0'
                }
            }

            // Custom properties

            property 'ec_deploy', {

                // Custom properties
                ec_notifierStatus = '0'
            }
        }

        // Custom properties

        property 'ec_deploy', {

            // Custom properties
            ec_notifierStatus = '0'
        }
        jobCounter = '4'
    }

    pipeline 'MotorBike StoreFront (Application-based)', {
        description = ''
        enabled = '1'
        releaseName = null
        templatePipelineName = null
        templatePipelineProjectName = null
        type = null

        formalParameter 'undeploy', defaultValue: 'false', {
            description = 'Undeploy all Microservices'
            expansionDeferred = '0'
            label = 'Undeploy'
            orderIndex = '1'
            required = '0'
            type = 'checkbox'
        }

        formalParameter 'deployOn', defaultValue: 'k8s', {
            expansionDeferred = '0'
            label = null
            orderIndex = '2'
            required = '1'
            type = 'select'
        }

        formalParameter 'ec_stagesToRun', defaultValue: null, {
            expansionDeferred = '1'
            label = null
            orderIndex = null
            required = '0'
            type = null
        }

        stage 'QE', {
            description = ''
            colorCode = null
            completionType = 'auto'
            condition = null
            duration = null
            parallelToPrevious = null
            pipelineName = 'MotorBike StoreFront (Application-based)'
            plannedEndDate = null
            plannedStartDate = null
            precondition = null
            resourceName = null
            waitForPlannedStartDate = '0'

            gate 'PRE', {
                condition = null
                precondition = null
            }

            gate 'POST', {
                condition = null
                precondition = null
            }

            task 'Deploy all (Kubernetes)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'false\' && myPipelineRuntime.deployOn==\'k8s\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'K8S'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Deploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Undeploy all (Kubernetes)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'true\' && myPipelineRuntime.deployOn==\'k8s\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'K8S'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Undeploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Deploy all (AzureContainerService)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'false\' && myPipelineRuntime.deployOn==\'acs\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'AzureContainerService'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Deploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Undeploy all (AzureContainerService)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'true\' && myPipelineRuntime.deployOn==\'acs\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'AzureContainerService'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Undeploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Deploy all (Docker)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'false\' && myPipelineRuntime.deployOn==\'docker\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'Docker'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Deploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Undeploy all (Docker)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'true\' && myPipelineRuntime.deployOn==\'docker\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'Docker'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Undeploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Deploy all (Openshift)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'false\' && myPipelineRuntime.deployOn==\'openshift\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'Openshift'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Deploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }

            task 'Undeploy all (Openshift)', {
                description = ''
                actualParameter = [
                        'ec_enforceDependencies': '1',
                ]
                advancedMode = '0'
                afterLastRetry = null
                alwaysRun = '0'
                condition = '$[/javascript myPipelineRuntime.undeploy==\'true\' && myPipelineRuntime.deployOn==\'openshift\']'
                deployerExpression = null
                deployerRunType = null
                duration = null
                enabled = '1'
                environmentName = 'Openshift'
                environmentProjectName = 'Microservices Demo'
                environmentTemplateName = null
                environmentTemplateProjectName = null
                errorHandling = 'stopOnError'
                gateCondition = null
                gateType = null
                groupName = null
                groupRunType = null
                insertRollingDeployManualStep = '0'
                instruction = null
                notificationEnabled = null
                notificationTemplate = null
                parallelToPrevious = null
                plannedEndDate = null
                plannedStartDate = null
                precondition = null
                requiredApprovalsCount = null
                resourceName = null
                retryCount = null
                retryInterval = null
                retryType = null
                rollingDeployEnabled = '0'
                rollingDeployManualStepCondition = null
                skippable = '0'
                snapshotName = null
                subapplication = 'MotorBike StoreFront'
                subpluginKey = null
                subprocedure = null
                subprocess = 'Undeploy'
                subproject = 'Microservices Demo'
                subservice = null
                subworkflowDefinition = null
                subworkflowStartingState = null
                taskProcessType = 'APPLICATION'
                taskType = 'PROCESS'
                waitForPlannedStartDate = '0'
            }
        }

        // Custom properties

        property 'ec_counters', {

            // Custom properties
            pipelineCounter = '10'
        }

        property 'ec_customEditorData', {

            // Custom properties

            property 'parameters', {

                // Custom properties

                property 'deployOn', {

                    // Custom properties

                    property 'options', {

                        // Custom properties

                        property 'option1', {

                            // Custom properties

                            property 'text', value: 'openshift', {
                                expandable = '1'
                            }

                            property 'value', value: 'openshift', {
                                expandable = '1'
                            }
                        }

                        property 'option2', {

                            // Custom properties

                            property 'text', value: 'k8s', {
                                expandable = '1'
                            }

                            property 'value', value: 'k8s', {
                                expandable = '1'
                            }
                        }

                        property 'option3', {

                            // Custom properties

                            property 'text', value: 'docker', {
                                expandable = '1'
                            }

                            property 'value', value: 'docker', {
                                expandable = '1'
                            }
                        }

                        property 'option4', {

                            // Custom properties

                            property 'text', value: 'acs', {
                                expandable = '1'
                            }

                            property 'value', value: 'acs', {
                                expandable = '1'
                            }
                        }
                        optionCount = '4'

                        property 'type', value: 'list', {
                            expandable = '1'
                        }
                    }
                }

                property 'undeploy', {

                    // Custom properties
                    checkedValue = 'true'
                    initiallyChecked = 'false'
                    uncheckedValue = 'false'
                }
            }
        }
    }
}