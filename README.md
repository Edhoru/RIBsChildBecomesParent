# RIBsChildBecomesParent
This is an example project to test RIBs architecture when a child becomes the parent of it's parent. The project presents a common scenario of apps that present a list of objects to select and see it's details (Think of these as products), from the details screen you can see a list of other objects (let's think about those as sellers) to pick from, from the seller's details you see a list of all the producs (type 1) they sell, and so on.

Flow:
1. From this Root RIBs pick a hat to open the child RIB called 'Hat'

2. From the 'Hat' RIB, you can see a list of pumpkins that can wear this hat

3. When you pick a pumpkin you open the 'Pumpkin' RIB as a child of 'Hat', this RIB display all the hats the pumpkin can wear.

4. From that list of hats you can pick a hat and open the 'Hat' RIB now as a child of 'Pumpkin'

This behavior can continue for ever, since the mock data has 2 pumpkins (pumpkins) and both can wear the same 2 hats. Is this the right way to handle this scenario?
