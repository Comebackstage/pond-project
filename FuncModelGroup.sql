USE [EPS]
GO
/****** Object:  UserDefinedFunction [dbo].[FuncModelGroup]    Script Date: 2/1/2023 4:51:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:  <Author,,Name>
-- Create date: <Create Date, ,>
-- Description: <Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[FuncModelGroup]
(
@Model nvarchar(50),
@FamilyCode nvarchar(50),
@CustCode nvarchar(50)
)
RETURNS   nvarchar(50)
AS
BEGIN


IF (select Count(*) from [EMSNREPORT].[dbo].[SkidSingleDimension] where CustomerCode=@CustCode)<1
--AND (select Count(*) from [EMSNREPORT].[dbo].[SkidSpecialDimension] where customerCode=@CustCode)<1 
BEGIN

IF @Model LIKE '%TW%' AND @FamilyCode LIKE 'SUMMIT%' AND(@Model NOT LIKE 'ZRT%' OR @Model NOT LIKE 'ZPT%' OR @Model NOT LIKE 'ZRDU%' OR @Model NOT LIKE 'ZRDT%')
	BEGIN
		SET @FamilyCode='SummitTW'
	END
IF @Model LIKE 'ZF%' AND @FamilyCode LIKE 'SUMMIT%'
	BEGIN
		SET @FamilyCode='Summit-ZF'
	END
IF @Model NOT LIKE '%TW%' AND (@Model LIKE '%550%' or  @Model LIKE '%551%' or  @Model LIKE '%455%' or  @Model LIKE '%425%')AND @FamilyCode LIKE 'SUMMIT%' 
AND (select Count(*) from [EMSNREPORT].[dbo].[SkidSpecialDimension] where customerCode=@CustCode and modelGroup =@FamilyCode)<1 
	BEGIN
		SET @FamilyCode='SUMMIT-550/551/455/425'
	END
IF @Model LIKE 'ZMD%' AND @Model LIKE '%275%'
	BEGIN
		SET @FamilyCode='MARINE-275'
	END
IF @Model LIKE 'ZMD%' AND @Model LIKE '%284%'
	BEGIN
		SET @FamilyCode='MARINE-284'
	END

IF (@Model LIKE 'ZMD%' AND @Model LIKE '%2E4%') or (@Model LIKE 'YMD%' AND @Model LIKE '%2E4%')
	BEGIN
		SET @FamilyCode='MARINE-2E4'
	END

IF @Model LIKE 'ZMD%' AND @Model LIKE '%984%'
	BEGIN
		SET @FamilyCode='MARINE-984'
	END

IF(@Model LIKE 'ZMD%' AND @Model LIKE '%9E4%') or (@Model LIKE 'YMD%' AND @Model LIKE '%9E4%')
	BEGIN
		SET @FamilyCode='MARINE-9E4'
	END

IF @Model LIKE 'ZMD%' AND @Model LIKE '%977%'
	BEGIN
		SET @FamilyCode='MARINE-977'
	END

IF @Model LIKE 'ZPI%' AND @Model LIKE '%496%'
	BEGIN
		SET @FamilyCode='ZPI-496'
	END

IF @Model LIKE 'ZPD%' OR @Model LIKE 'ZRD%' OR @Model LIKE 'ZBD%' OR @Model LIKE 'ZRI%' OR @Model LIKE 'ZRJ%' OR @Model LIKE 'ZPJ%'  
OR (@Model LIKE 'ZPI%' AND @Model LIKE '%496')OR   @Model LIKE 'ZXD%' OR   @Model LIKE 'ZXJ%'
	BEGIN
		SET @FamilyCode='Digital'
	END
IF @Model LIKE 'ZRT%' OR @Model LIKE 'ZPT%' OR @Model LIKE 'ZRDU%' OR @Model LIKE 'ZRDT%'
	BEGIN
		SET @FamilyCode='TANDEM ' + @FamilyCode
	END
IF @Model LIKE 'YP%' 
	BEGIN
		SET @FamilyCode='QUEST'
	END
END
Return @FamilyCode
END
