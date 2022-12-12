select*
from [dbo].[Nashville Housing]

---Standardize Data format

select SaleDateConverted, CONVERT (Date,SaleDate)
from[dbo].[Nashville Housing]

update [dbo].[Nashville Housing]
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE [dbo].[Nashville Housing]
Add SaleDateConverted Date;


update [dbo].[Nashville Housing]
SET SaleDateConverted = CONVERT(Date,SaleDate)


---Populate Property Address  data

select *
from [dbo].[Nashville Housing]
---where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from [dbo].[Nashville Housing] a
JOIN[dbo].[Nashville Housing] b
on a.ParcelID= b.ParcelID
AND a.[uniqueID] <> b.[uniqueID]
where a.PropertyAddress is null


Update a
SET propertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from [dbo].[Nashville Housing] a
JOIN[dbo].[Nashville Housing] b
on a.ParcelID= b.ParcelID
AND a.[uniqueID] <> b.[uniqueID]
where a.PropertyAddress is null


---breaking out address into Individual columns (Address, City, State)

select PropertyAddress
from [dbo].[Nashville Housing]
---where PropertyAddress is null
---order by ParcelID

select
SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from [dbo].[Nashville Housing]

ALTER TABLE [dbo].[Nashville Housing]
Add PropertySplitAddress Nvarchar(255);

update [dbo].[Nashville Housing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CHARINDEX(',',PropertyAddress) -1)                 


ALTER TABLE [dbo].[Nashville Housing]
Add PropertySplitCity Nvarchar(255);

update [dbo].[Nashville Housing]
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


select *
from [dbo].[Nashville Housing]


select OwnerAddress
from [dbo].[Nashville Housing]

select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from [dbo].[Nashville Housing]


ALTER TABLE [dbo].[Nashville Housing]
Add OwnerSplitAddress Nvarchar(255);

update [dbo].[Nashville Housing]
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE [dbo].[Nashville Housing]
Add OwnerSplitCity Nvarchar(255);

update [dbo].[Nashville Housing]
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE [dbo].[Nashville Housing]
Add OwnerSplitState Nvarchar(255);

update [dbo].[Nashville Housing]
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)



---change Y and N to YES and NO in SoldAsVacant column

select distinct (SoldAsVacant), count(SoldAsVacant)
from [dbo].[Nashville Housing]
group by SoldAsVacant
order by 2


select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'YES'
       When SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
	   FROM[dbo].[Nashville Housing]

	   update [dbo].[Nashville Housing]
	   SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'YES'
       When SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
	   FROM[dbo].[Nashville Housing]


	   ---delete unused columns

	   alter table [dbo].[Nashville Housing]
	   DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

	   
