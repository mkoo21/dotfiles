"use client"

import { useMemo, useEffect, useRef } from 'react';
import { initScene, initLoop } from './boids';

const CANVAS_HEIGHT = 600;

const Canvas = () => {
    const containerRef = useRef<HTMLDivElement>(null);
    const { scene, camera, renderer } = useMemo(() => {
        return initScene();
    }, []);

    useEffect(() => {
        // set renderer dimensions and add it to the dom
        const element = containerRef.current;
        if(!element) return;
        const [ canvasWidth, canvasHeight ] = [ element.clientWidth || window.innerWidth, CANVAS_HEIGHT ];
        renderer.setSize( canvasWidth, canvasHeight );
        element.replaceChildren( renderer.domElement );
        const loop = initLoop(scene, camera);

        const animate = () => {
            loop();
            requestAnimationFrame( animate );
        
            renderer.render( scene, camera );
        }
        animate();

    }, [camera, renderer, scene]);

    return <div ref={containerRef}/>;
};

export default Canvas;