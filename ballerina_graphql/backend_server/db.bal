public Order[] orderTable = [
    {
        orderId: "HM-278", 
        quantity: 5, 
        item: "TV", 
        customerId: "C-124", 
        shipId: "S-8", 
        date: "22-11-2023", 
        status: PENDING,
        shippingAddress: {
            number: "120",
            street: "Park St",
            city: "Brisbane",
            state: "QLD"
        }
    },
    {
        orderId: "HM-340", 
        quantity: 3, 
        item: "IPhone 14", 
        customerId: "C-73", 
        shipId: "S-32", 
        date: "12-11-2023", 
        status: DELIVERED,
        shippingAddress: {
            number: "15",
            street: "Briggs Rd",
            city: "Springwood",
            state: "QLD"
        }
    }
];
