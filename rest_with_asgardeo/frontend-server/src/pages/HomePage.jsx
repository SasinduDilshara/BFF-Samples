import React from 'react';
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

    return <div style={{minHeight:"100vh", display:"flex", justifyContent:"center", alignItems:"center"}}>
          <CustomButton color="primary" onClick={() => signIn()} disabled={false} label={"Log In"} size={'large'}/>
      </div>
}
