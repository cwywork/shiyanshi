<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class UserServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }

    /**
     * Register the application services.
     *
     * @return void
     */
    public function register()
    {
        $this->app->singleton('user', function ($app) {
            return new class {
                protected $property;

                public function set(string $key, $value) 
                {
                    $this->property[$key] = $value;
                }

                public function get(string $key, $default=null)
                {
                    return $this->property[$key] ?? $default;
                }

                public function __get(string $key)
                {
                    return $this->get($key);
                }

                public function __set(string $key, $value)
                {
                    $this->set($key, $value);
                }
            };
        });
    }
}
