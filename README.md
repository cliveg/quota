# Azure Subscription Quota Report
Reads all accessible subscriptions for a subset of Azure locations.

Outputs a CSV file containing quota utilization you can open in Excel and filter.

## Usage
This is a linux bash script which uses Azure CLI, you should run this from your browser using [Azure Cloud Shell (bash)](https://docs.microsoft.com/en-us/azure/cloud-shell/overview), or alternatively install [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) locally on a Linux computer.
1. Download Script
```
wget -O quota.sh https://raw.githubusercontent.com/cliveg/quota/master/quota.sh
```
2. If needed, update the 'locations' variable (line 2) in quota.sh to add additional Azure regions/locations. Default includes: westus2 eastus2 eastus canadacentral southcentralus
```
nano quota.sh
```
3. Execute Script

```
bash ./quota.sh
```

4. Open the CSV file locally to analyze the results

- Click Download from the Cloud Shell toolbar under 'Upload/Download Files' to download quota.csv and open it with Microsoft Excel. 

- Convert the data to a table by pressing CTRL + A, and then CTRL + T. To add a column for percentage used, in cell ```H2``` add formula ```=[@currentValue]/[@limit]``` and set the Number Format to ```Percentage```.
- Use Conditional Formatting. Select column ```H``` and under the toolbar menu choose ```Conditional Formatting```, then ```Color Scales``` and then choose a scale e.g. ```Red - Yellow - Green Color Scale```.

## Links related to Requesting Quota Increases
The standard vCPU quota is enforced at two tiers for each subscription in each region:

- The first tier is the total regional vCPUs limit, across all VM series.
The total regional vCPU limit can't exceed the total approved quota across all VM series for the region.

- The second tier is the per-VM series vCPUs limit, such as the D-series vCPUs.


> [Standard quota: Increase limits by VM series](https://docs.microsoft.com/en-us/azure/azure-portal/supportability/per-vm-quota-requests)

> [Standard quota: Increase limits by region](https://docs.microsoft.com/en-us/azure/azure-portal/supportability/regional-quota-requests)

> [Request quota increases for Azure SQL Database](https://docs.microsoft.com/en-us/azure/sql-database/quota-increase-request)

> [Manage and request quotas for Azure resources (for Machine Learning, but has broader coverage)](https://docs.microsoft.com/en-us/azure/machine-learning/how-to-manage-quotas)

## Related Scripts
[Azure Resource Quotas into a Log Analytics Workspace (Using PowerShell)](https://github.com/brandofriva/AzureQuotas) - Azure Automation script to enable monitoring and alerting.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)