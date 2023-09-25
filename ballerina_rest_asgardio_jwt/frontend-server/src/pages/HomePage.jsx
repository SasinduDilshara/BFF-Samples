import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuthContext } from "@asgardeo/auth-react";
import CustomButton from '../components/CustomButton';
import OrderPage from './OrderPage';

export default function HomePage() {
  const { state } = useAuthContext();

  return (
    !state.isAuthenticated ?
      <GuestHomePage/>
      :
      <OrderPage />
  );
}

function GuestHomePage() {
    const {signIn} = useAuthContext();

    return <React.Fragment>
          <CustomButton color="primary" onClick={() => signIn()} disabled={false} label={"Log In"} size={'large'}/>
      </React.Fragment>
}
