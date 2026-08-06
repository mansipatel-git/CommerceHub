import { Button, HelperText } from "@windmill/react-ui";
import { useCart } from "context/CartContext";
import { formatCurrency } from "helpers/formatCurrency";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import PulseLoader from "react-spinners/PulseLoader";
import OrderService from "services/order.service";
import OrderSummary from "./OrderSummary";

const PaymentForm = ({ previousStep }) => {
  const { cartSubtotal, cartTotal, cartData, setCartData } = useCart();

  const [error, setError] = useState(null);
  const [isProcessing, setIsProcessing] = useState(false);

  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      setIsProcessing(true);

      // Simulate payment processing
      await new Promise((resolve) => setTimeout(resolve, 1500));

      // Save order
      // Generate Order Reference
      const orderRef = `CH-${Math.floor(100000 + Math.random() * 900000)}`;
      //await OrderService.createOrder(cartSubtotal, cartTotal, orderRef, "Cash On Delivery");
      // Simulate successful order
      console.log("Order placed successfully");
      // Clear cart
      setCartData({
        ...cartData,
        items: [],
      });

      navigate("/cart/success", {
        state: {
          fromPaymentPage: true,
        },
      });
    } catch (err) {
      setError({
        message: "Unable to place order. Please try again.",
      });
    } finally {
      setIsProcessing(false);
    }
  };

  return (
    <div className="w-full md:w-1/2">
      <h1 className="text-3xl font-semibold text-center mb-2">Checkout</h1>

      <OrderSummary />

      <h2 className="font-medium text-2xl mb-4">Confirm Your Order</h2>

      {error && <HelperText valid={false}>{error.message}</HelperText>}

      <form onSubmit={handleSubmit}>
        <div className="flex justify-between py-4">
          <Button layout="outline" size="small" onClick={previousStep}>
            Back
          </Button>

          <Button type="submit" size="small" disabled={isProcessing}>
            {isProcessing ? (
              <PulseLoader size={10} color="#0a138b" />
            ) : (
              `Place Order (${formatCurrency(cartSubtotal)})`
            )}
          </Button>
        </div>
      </form>
    </div>
  );
};

export default PaymentForm;
