import Head from 'next/head';
import { CacheProvider } from '@emotion/react';
import { CssBaseline } from '@mui/material';
import { ThemeProvider } from '@mui/material/styles';
import { useNProgress } from 'src/hooks/use-nprogress';
import { createTheme } from 'src/theme';
import { createEmotionCache } from 'src/utils/create-emotion-cache';
import 'simplebar-react/dist/simplebar.min.css';
import { ApolloProvider} from '@apollo/client';
import { apolloClient1 } from 'src/api/config';

const clientSideEmotionCache = createEmotionCache();

const App = (props) => {
  const { Component, emotionCache = clientSideEmotionCache, pageProps } = props;

  useNProgress();

  const getLayout = Component.getLayout ?? ((page) => page);

  const theme = createTheme();

  return (
    <CacheProvider value={emotionCache}>
      <Head>
        <title>
          MegaPort
        </title>
        <meta
          name="viewport"
          content="initial-scale=1, width=device-width"
        />
      </Head>
          <ThemeProvider theme={theme}>
          <ApolloProvider client={apolloClient1}>
            <CssBaseline />
              {
                  getLayout(<Component {...pageProps} />)
              }
              </ApolloProvider>
          </ThemeProvider>
    </CacheProvider>
  );
};

export default App;
