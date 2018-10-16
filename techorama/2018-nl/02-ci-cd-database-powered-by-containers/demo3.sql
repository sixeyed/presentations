<<<<<<< HEAD
=======
-- check databases
/*
select name, physical_name from sys.master_files
*/

>>>>>>> d8c53b9404d18b8c94bd9792563928db1b2c6ef5
--insert sample assets

INSERT INTO Assets (AssetTypeId, LocationId, PurchaseDate, PurchasePrice, AssetTag, AssetDescription)
VALUES (1, 1, '2016-11-14', '1999.99', 'SC0001', 'New MacBook with Emoji Bar');

INSERT INTO Assets (AssetTypeId, LocationId, PurchaseDate, PurchasePrice, AssetTag, AssetDescription)
VALUES (1, 1, '2016-11-14', '800', 'SC0002', 'Logitech Office Cam');

--select assets

SELECT * FROM Assets;