enum SideBarContentType {
  product, cart, notifications, checkout, paymentCompleted,
  order
}

enum OrderStatus { inProgress, cancelled, completed }

enum PaymentMethod {paypal, applePay, mastercard}

enum EventCause {
  viewProductDetails,
  viewCart,
  viewNotifications,
  viewCheckout,
  viewOrder,
  paymentCompleted,
  closeSideBar,
  openSpecificBoard
}
