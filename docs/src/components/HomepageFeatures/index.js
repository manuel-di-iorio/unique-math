import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Robust and Evolving Math Library',
    src: require('@site/static/img/headline_simple.png').default,
    description: (
      <>
        Built to grow with your needs, Unique Math offers a comprehensive suite of advanced mathematical functions, ranging from vectors and matrices to complex numbers and quaternions, ensuring your projects have the computational power they require.
      </>
    ),
  },
  {
    title: 'Maximum Performance',
    src: require('@site/static/img/headline_puzzle.png').default,
    description: (
      <>
        Optimized for GameMaker, Unique Math uses arrays and functional programming to minimize garbage collection and maximize execution speed.
      </>
    ),
  },
  {
    title: 'Inspired by the best',
    src: require('@site/static/img/headline_three.png').default,
    description: (
      <>
        Unique Math takes inspiration from the renowned three.js math library, bringing its proven, intuitive approach to GameMaker. 
      </>
    ),
  },
];

function Feature({ Svg, src, title, description }) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        {src ?
          <img src={src} className={styles.featureSvg} role="img" /> :
          <Svg className={styles.featureSvg} role="img" />}
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
